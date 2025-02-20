//
//  WifiSecurityCheckScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct WifiSecurityCheckScreen: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 120) {
            Text("Ready to scan this network")
            Image(systemName: "applelogo")
                .resizable()
                .scaledToFit()
                .frame(width: 270, height: 195)
            Spacer()
            NavigationLink(destination: WifiCheckResultScreen()) {
                Text("Scan current network")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
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
        .padding(EdgeInsets(top: 140, leading: 24, bottom: 24, trailing: 24))
        

    }
}

#Preview {
    WifiSecurityCheckScreen()
}

