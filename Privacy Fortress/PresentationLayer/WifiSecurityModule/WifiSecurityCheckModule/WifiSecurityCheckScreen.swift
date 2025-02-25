//
//  WifiSecurityCheckScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct WifiSecurityCheckScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = WifiSecurityCheckViewModel()
    @State private var navigateToResult = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 120) {
                    Text("Ready to scan this network")
                        .font(.custom(FontsManager.SFSemibold.font, size: 24))
                        .foregroundColor(ColorManager.buttonActiveColor.color)
                    Image(IconsManager.icModem.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270, height: 195)
                    Spacer()
                    Button(action: {
                        Task {
                            // TODO - logic
                            _ = await viewModel.startWiFiSecurityCheck()
                            navigateToResult = true
                        }
                    }) {
                        Text("Scan current network")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .font(.custom(FontsManager.SFSemibold.font, size: 20))
                            .background(ColorManager.buttonActiveColor.color)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(
                        destination: WifiCheckResultScreen(),
                        isActive: $navigateToResult
                    ) { EmptyView() }
                }
                .padding(.top, Constants.isIPad ? 391 : 143)
                .padding(.horizontal, Constants.isIPad ? 190 : 24)
                .frame(height: geometry.size.height)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
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
}

#Preview {
    WifiSecurityCheckScreen()
}

