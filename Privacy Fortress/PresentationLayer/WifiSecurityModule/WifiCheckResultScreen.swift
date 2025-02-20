//
//  WifiCheckResultScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct WifiCheckResultScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State var viewState: WifiCheckResultScreenViewState = .wifiIsSecure
    @State private var showOverlay = false

    var body: some View {
        
//        switch viewState {
//        case .wifiIsSecure:
//            showWifiIsSecureViewState()
//        case .wifiIsNotSecure:
//            showWifiIsNotSecureViewState()
//        }
        
        ZStack {
            // Semi-transparent Background + Overlay
            showWifiIsNotSecureViewState()

            if showOverlay {
                Color.black.opacity(0.5) // Semi-transparent background
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("This is an overlay!")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Button("Close") {
                        showOverlay.toggle()
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(40)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
            }
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
        
        .background(Color.gray.opacity(0.1))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
    }
    
    private func showWifiIsNotSecureViewState() -> some View {
        VStack() {
            Text("Your Wi-Fi is insecure")
                .padding(EdgeInsets(top: 229, leading: 24, bottom: 36, trailing: 24))
            Text("Select the type of network you used during the check:")
                .font(.system(size: 14, weight: .light))
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 36, trailing: 24))
             
            HStack(spacing: 16) {
                Image(systemName: "lock.shield.fill")
                    .frame(width: 110, height: 110)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showOverlay.toggle()
                    }
                
                Image(systemName: "lock.shield.fill")
                    .frame(width: 110, height: 110)
                    .background(Color.green)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .onTapGesture {
                        showOverlay.toggle()
                    }
            }
            
            Spacer()
            VStack {
                Text("Remember to check Wi-Fi security in unfamiliar locations.")
                    .font(.system(size: 12, weight: .light))
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Back to Wi-Fi security check")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 34, trailing: 24))
    }
    
    private func showWifiIsSecureViewState() -> some View {
        VStack(spacing: 24) {
            Text("Your Wi-Fi is secure")
                .padding(EdgeInsets(top: 229, leading: 24, bottom: 0, trailing: 24))
            VStack(spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: "lock.shield.fill")
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                    Text("Privacy Fortness")
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                .background(Color.white)
                .cornerRadius(10)
                
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                            .padding(.leading, 16)
                        Text("Privacy Fortness")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "lock.shield.fill")
                            .frame(width: 24, height: 24)
                            .padding(.leading, 16)
                        Text("Privacy Fortness")
                        Spacer()
                    }
                    .frame(maxWidth: 56, minHeight: 56, maxHeight: 56)
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer()
            VStack {
                Text("Remember to check Wi-Fi security in unfamiliar locations.")
                    .font(.system(size: 12, weight: .light))
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Back to Wi-Fi security check")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 34, trailing: 24))
        }
    }
    
}

#Preview {
    WifiCheckResultScreen()
}
