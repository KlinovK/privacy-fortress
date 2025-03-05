//
//  MediaSafeScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI

struct MediaSafeScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State var viewState: MediaSafeViewState = .noFiles

    var body: some View {
        
        let items = Array(1...20)
        
        let columns = [
            GridItem(.flexible(), spacing: 1.5),
            GridItem(.flexible(), spacing: 1.5),
            GridItem(.flexible(), spacing: 1.5)
        ]
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1.5) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.blue)
                            .frame(height: 133)
                        Text("Item \(item)")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(ColorManager.mainBackground.color)
        .navigationTitle("Media Safe")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { addMediaItem() }) {
                    Text("Add")
                        .font(.custom(FontsManager.SFRegular.font, size: 17))
                        .foregroundColor(ColorManager.textBlueColor.color)
                }
            }
        }
    }
    
    private func addMediaItem() {
        print("Add button tapped")
    }
}

#Preview {
    MediaSafeScreen()
}

