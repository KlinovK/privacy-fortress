//
//  PasswordVaultScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 04/03/25.
//

import SwiftUI

struct PasswordVaultScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = PasswordVaultViewModel()
    @State private var navigateToPaywall = false

    private let columns = [
        GridItem(.flexible(), spacing: 1.5),
    ]
    
    private let testPasswords = [
            PasswordItem(title: "Email", username: "user@example.com", password: "••••••••")
        ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                                    ForEach(testPasswords) { item in
                                        PasswordItemView(item: item)
                                            .frame(maxWidth: .infinity)
                                            .padding(.horizontal)
                                    }
                                }
            }
            .background(Color.white)
            .navigationTitle("Password Vault")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                    }
                }
            }
//            .overlay(
//                LimitOfFreeStorageAlert(isPresented: $viewModel.isNeedToPresentNoAccessAlert), onDismiss: {
//                    navigateToPaywall = true
//                })
//            )
    
            
            .onAppear {
                viewModel.updateViewState(passwordItems: [])
            }
            .navigationDestination(isPresented: $navigateToPaywall) {
                PaywallScreen()
            }
        }
    }
}

#Preview {
    PasswordVaultScreen()
}

// Single Password Item View
struct PasswordItemView: View {
    let item: PasswordItem
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon placeholder
            Image(systemName: "lock.fill")
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(item.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(item.password)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Copy button
            Button(action: {
                UIPasteboard.general.string = item.password
            }) {
                Image(systemName: "doc.on.doc")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}


struct PasswordItem: Identifiable {
    let id = UUID()
    let title: String
    let username: String
    let password: String
}
