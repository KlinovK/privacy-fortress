//
//  MediaSafeViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import Photos
import CoreData
import SwiftUI

@MainActor
final class MediaSafeViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var viewState: MediaSafeViewState = .noFiles
    @Published var selectedMedia: [MediaSelection] = []
    @Published var showingPhotoPicker = false
    @Published var isNeedToPresentLimitsAlert = false
    @Published private(set) var hasAddedPhotos = false

    // MARK: - Private Properties
    
    private var failedAssets: [PHAsset] = []
    private let photoLibrary = PHPhotoLibrary.shared()
    
    public func showPhotoPicker() {
        if hasAddedPhotos && UserSessionManager.shared.isUserSubscribed == false  {
            isNeedToPresentLimitsAlert = true
        } else {
            Task {
                let status = await requestPhotoLibraryAuthorization()
                switch status {
                case .authorized, .limited:
                    showingPhotoPicker = true
                case .denied, .restricted:
                    print("Photo Library access denied")
                case .notDetermined:
                    print("Photo Library access not determined - unexpected state")
                @unknown default:
                    break
                }
            }
        }
    }

    public func saveImagesToCoreData(_ media: [MediaSelection], context: NSManagedObjectContext) {
        failedAssets.removeAll()
        
        for selection in media {
            do {
                _ = createMediaItem(from: selection, in: context)
                try context.save()
                failedAssets.append(selection.asset)
                hasAddedPhotos = true
            } catch {
                logError(error, message: "Failed to save media item")
                failedAssets.append(selection.asset)
            }
        }
        
        if !failedAssets.isEmpty {
            deleteFailedAssets()
        }
        
        updateViewState(mediaItems: fetchMediaItems(from: context))
    }

    public func updateViewState(mediaItems: [MediaItemEntity]) {
        let images = mediaItems.compactMap { $0.imageData.flatMap(UIImage.init) }
        viewState = images.isEmpty ? .noFiles : .containsFiles(images.map { MediaItem.image($0) })
    }

    // MARK: - Asset Deletion
    
    private func deleteFailedAssets() {
        guard !failedAssets.isEmpty else { return }
        
        Task {
            do {
                try await deleteAssets(failedAssets)
                print("Successfully deleted failed assets from Photos library")
                failedAssets.removeAll()
            } catch {
                logError(error, message: "Error deleting failed assets")
            }
        }
    }

    private func requestPhotoLibraryAuthorization() async -> PHAuthorizationStatus {
        await withCheckedContinuation { continuation in
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                continuation.resume(returning: status)
            }
        }
    }

    private func createMediaItem(from selection: MediaSelection, in context: NSManagedObjectContext) -> MediaItemEntity {
        let newItem = MediaItemEntity(context: context)
        newItem.id = UUID()
        newItem.dateAdded = Date()
        if let imageData = selection.image.jpegData(compressionQuality: 1.0) {
            newItem.imageData = imageData
        }
        return newItem
    }

    private func fetchMediaItems(from context: NSManagedObjectContext) -> [MediaItemEntity] {
        let request = MediaItemEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \MediaItemEntity.dateAdded, ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            logError(error, message: "Error fetching media items")
            return []
        }
    }

    private func deleteAssets(_ assets: [PHAsset]) async throws {
        try await photoLibrary.performChanges {
            PHAssetChangeRequest.deleteAssets(assets as NSFastEnumeration)
        }
    }

    private func logError(_ error: Error, message: String) {
        let nsError = error as NSError
        print("\(message): \(nsError), \(nsError.userInfo)")
    }
}
