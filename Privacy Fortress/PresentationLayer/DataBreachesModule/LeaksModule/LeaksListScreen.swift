//
//  LeaksListScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct LeaksListScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedLeak: Breach?
    @State private var navigateToResult = false
    let breaches: [Breach]

    var body: some View {
        List {
            ForEach(breaches.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 0) {
                    setupCellView(index: index)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        
        .navigationDestination(isPresented: $navigateToResult) {
            if let leak = selectedLeak {
                LeakDetailsScreen(leak: leak)
            }
        }
        .padding(.top, Constants.isIPad ? 32 : 24)
        .padding(.horizontal, Constants.isIPad ? 190 : 16)
        .background(ColorManager.mainBackground.color)
        
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationTitle("Data Breach Monitoring")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
    
    private func setupCellView(index: Int) -> some View {
        HStack(spacing: 12) {
            setCellImage(index: index)
            
            Text(breaches[index].title)
                .foregroundColor(ColorManager.textDefaultColor.color)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
            Spacer()
            
            Image(IconsManager.icChevronRight.image)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            selectedLeak = breaches[index]
            navigateToResult = true
        }
    }
    
    @ViewBuilder
    private func setCellImage(index: Int) -> some View {
        if let imageURL = breaches[index].logoPath, let url = URL(string: imageURL) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                case .failure:
                    fallbackImage
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            fallbackImage
        }
    }

    private var fallbackImage: some View {
        Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(.green)
    }}


