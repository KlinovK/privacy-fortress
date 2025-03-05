//
//  PhotoPickerManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import Foundation
import PhotosUI
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedMedia: [MediaSelection]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 0
        config.filter = .images 
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            var newMedia: [MediaSelection] = []

            let group = DispatchGroup()

            for result in results {
                group.enter()
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let uiImage = image as? UIImage {
                            let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [result.assetIdentifier ?? ""], options: nil)
                            if let asset = assetResults.firstObject {
                                newMedia.append(MediaSelection(image: uiImage, asset: asset))
                            }
                        }
                        group.leave()
                    }
                } else {
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.parent.selectedMedia = newMedia
            }
        }
    }
}
