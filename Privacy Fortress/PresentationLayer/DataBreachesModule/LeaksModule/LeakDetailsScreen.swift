//
//  LeakDetailsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct LeakDetailsScreen: View {
    
    let leak: Breach
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 12) {
                        
                        createNotDetectedDataBreackesCheckView(leakCellType: .data, leak: leak)
                        createNotDetectedDataBreackesCheckView(leakCellType: .compromised, leak: leak)
                        createNotDetectedDataBreackesCheckView(leakCellType: .description, leak: leak)
                        createNotDetectedDataBreackesCheckView(leakCellType: .recommendations, leak: leak)

                        Spacer()
                        Text("Don’t ignore these breaches. Acting quickly can help minimize the risk of unauthorized access and data misuse.")
                            .font(.custom(FontsManager.SFRegular.font, size: 14))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 4)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Close")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(ColorManager.buttonActiveColor.color)
                                .foregroundColor(.white)
                                .font(.custom(FontsManager.SFSemibold.font, size: 20))
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding(.top, Constants.isIPad ? 204 : 24)
                    .padding(.horizontal, Constants.isIPad ? 190 : 16)
                    .frame(height: geometry.size.height)
                }
                .scrollIndicators(.hidden)
                .background(ColorManager.mainBackground.color)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationTitle("Leak")
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
    
    private func createNotDetectedDataBreackesCheckView(leakCellType: LeakCellType, leak: Breach) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(getCellImage(leakCellType: leakCellType))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.green)
                Text(getCellTitleAndSubtitle(leakCellType: leakCellType, leak: leak).0)
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
            }
            
            HStack {
                Text(getCellTitleAndSubtitle(leakCellType: leakCellType, leak: leak).1)
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFRegular.font, size: 12))
            }
            .padding(.leading, 33)
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private func getCellTitleAndSubtitle(leakCellType: LeakCellType, leak: Breach) -> (title: String, subtitle: String) {
        switch leakCellType {
        case .data:
            return ("Data:", "\(leak.breachDate)")
        case .compromised:
            return ("Compromised:", "\(leak.title)")
        case .description:
            return ("Description", "\(leak.getFormattedDescription())")
        case .recommendations:
            return ("Recommendations", "- Сhange your password for these accounts immediately. \n- Enable two-factor authentication to add an extra layer of security.")
        }
    }
    
    private func getCellImage(leakCellType: LeakCellType) -> String {
        switch leakCellType {
        case .data:
            return IconsManager.icDataLeak.image
        case .compromised:
            return IconsManager.icCompromisedLeak.image
        case .description:
            return IconsManager.icDescriptionLeak.image
        case .recommendations:
            return IconsManager.icDescriptionLeak.image
        }
    }
    
}
