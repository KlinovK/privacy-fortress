//
//  MediaSafeScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI

struct MediaSafeScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @StateObject private var viewModel = MediaSafeViewModel()
    
    @State private var navigateToPaywall = false
    @State private var selectedMediaItem: MediaItem?
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MediaItemEntity.dateAdded, ascending: true)],
        animation: .default
    )
    
    private var mediaItems: FetchedResults<MediaItemEntity>

    private let columns = [
        GridItem(.flexible(), spacing: 1.5),
        GridItem(.flexible(), spacing: 1.5),
        GridItem(.flexible(), spacing: 1.5)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                MediaSafeContentView(viewState: viewModel.viewState, columns: columns)
            }
            .background(Color.white)
            .navigationTitle("Media Safe")
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
                        viewModel.showPhotoPicker()
                    }) {
                        Text("Add")
                            .font(.custom(FontsManager.SFRegular.font, size: 17))
                            .foregroundColor(ColorManager.textBlueColor.color)
                    }
                }
            }
            .overlay(
                LimitOfFreeStorageAlert(isPresented: $viewModel.isNeedToPresentLimitsAlert, onDismiss: {
                    navigateToPaywall = true
                })
            )
            .sheet(isPresented: $viewModel.showingPhotoPicker) {
                PhotoPicker(selectedMedia: $viewModel.selectedMedia)
            }
            .onChange(of: viewModel.selectedMedia) { newMedia in
                viewModel.saveImagesToCoreData(newMedia, context: viewContext)
            }
            .onAppear {
                viewModel.updateViewState(mediaItems: Array(mediaItems))
            }
            .navigationDestination(isPresented: $navigateToPaywall) {
                PaywallScreen() 
            }
        }
    }
}

#Preview {
    MediaSafeScreen()
}

