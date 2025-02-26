//
//  LeaksListScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct LeaksListScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedLeak: Leak?
    @State private var navigate = false
    
    let leaks: [Leak] = [
        Leak(title: "Email Leak", description: "Your email was found in a data breach.", date: "Feb 25, 2024"),
        Leak(title: "Password Compromise", description: "Your password was exposed.", date: "Jan 12, 2024"),
        Leak(title: "Credit Card Leak", description: "Your card details were found online.", date: "Mar 5, 2024")
    ]
    var body: some View {
        NavigationStack {
            List {
                ForEach(leaks.indices, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.green)
                            
                            Text(leaks[index].title)
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
                            selectedLeak = leaks[index]
                            navigate = true
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            
            .navigationDestination(isPresented: $navigate) {
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

    }
}

#Preview {
    LeaksListScreen()
}
