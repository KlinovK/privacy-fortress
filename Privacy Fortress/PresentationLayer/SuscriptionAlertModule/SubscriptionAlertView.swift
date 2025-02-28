//
//  SubscriptionAlertView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 27/02/25.
//

import SwiftUI

struct SubscriptionAlertView: View {
    
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)

                    Text("Warning")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Are you sure you want to proceed? This action cannot be undone.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }

                        Button(action: {
                            print("Confirmed") // Add action here
                            isPresented = false
                        }) {
                            Text("Confirm")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .frame(maxWidth: 300)
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}
