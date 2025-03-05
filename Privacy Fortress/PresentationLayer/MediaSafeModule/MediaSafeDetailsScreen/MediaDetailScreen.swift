//
//  MediaDetailScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import SwiftUI

struct MediaDetailScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: MediaDetailViewModel

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(mediaItem: MediaItem, mediaItems: [MediaItem]) {
        _viewModel = StateObject(wrappedValue: MediaDetailViewModel(mediaItem: mediaItem, mediaItems: mediaItems))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.mediaItem.dateAdded, formatter: dateFormatter)")
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .padding(.bottom, 29)
                .padding(.leading, 24)
            
            Image(uiImage: viewModel.mediaItem.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.6)
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.mediaItems, id: \.id) { item in
                        Image(uiImage: item.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .onTapGesture {
                                viewModel.selectMediaItem(item)
                            }
                    }
                }
            }
        }
        .padding(.horizontal, Constants.isIPad ? 53 : 0)
        .padding(.vertical, Constants.isIPad ? 20 : 21)
        .background(ColorManager.backgroundOverlayColor.color)
        .navigationTitle("Media Safe Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.presentRestoreAlert = true
                }) {
                    Text("Restore")
                }
            }
        }
        .overlay(
            RestoreMediaAlert(isPresented: $viewModel.presentRestoreAlert, onDismiss: { isNeedToRestore in
                if isNeedToRestore {
                    viewModel.restorePhotoToLibrary()
                }
            })
        )
    }
}

