//
//  MediaSafeDetailsViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import SwiftUI
import Photos

class MediaDetailViewModel: ObservableObject {
    @Published var mediaItem: MediaItem
    @Published var presentRestoreAlert = false
    
    let mediaItems: [MediaItem]
    
    init(mediaItem: MediaItem, mediaItems: [MediaItem]) {
        self.mediaItem = mediaItem
        self.mediaItems = mediaItems
    }
    
    func selectMediaItem(_ item: MediaItem) {
        mediaItem = item
    }
    
    func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status == .authorized || status == .limited)
            }
        }
    }
    
    func restorePhotoToLibrary() {
        requestPhotoLibraryAccess { [weak self] granted in
            guard let self = self, granted else {
                print("Photo library access denied. Please enable it in Settings.")
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: self.mediaItem.image)
            }) { success, error in
                DispatchQueue.main.async {
                    if success {
                        print("Photo restored to library successfully!")
                    } else if let error = error {
                        print("Failed to restore photo: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
