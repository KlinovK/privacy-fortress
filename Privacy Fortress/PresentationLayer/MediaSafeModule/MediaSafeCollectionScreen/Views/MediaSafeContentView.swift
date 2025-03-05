//
//  MediaSafeContentView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import SwiftUI

struct MediaSafeContentView: View {
    let viewState: MediaSafeViewState
    let columns: [GridItem]
    
    var body: some View {
        switch viewState {
        case .noFiles:
            NoFilesView()
        case .containsFiles(let items):
            MediaGridView(items: items, columns: columns)
        }
    }
}
