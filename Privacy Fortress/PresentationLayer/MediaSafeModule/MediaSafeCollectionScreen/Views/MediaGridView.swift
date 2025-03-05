//
//  MediaGridView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import SwiftUI

struct MediaGridView: View {
    let items: [MediaItem]
    let columns: [GridItem]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 1.5) {
            ForEach(items) { item in
                NavigationLink(destination: MediaDetailScreen(mediaItem: item, mediaItems: items)) {
                    Image(uiImage: item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipped()
                }
            }
        }
        .padding(.horizontal, Constants.isIPad ? 0 : 0)
    }
}
