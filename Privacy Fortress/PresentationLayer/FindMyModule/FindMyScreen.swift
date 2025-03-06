//
//  FindMyScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 25/02/25.
//

import SwiftUI

struct FindMyScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    createScreenCells()
                    Spacer()
                    
                    Text("Go to settings")
                        .font(.custom(FontsManager.SFSemibold.font, size: 20))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(ColorManager.buttonActiveColor.color)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            openAppSettings()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20
                                            , trailing: 0))
                }
                .padding(.bottom, 20)
                .padding(.top, Constants.isIPad ? 24 : 16)
                .padding(.horizontal, Constants.isIPad ? 190 : 16)
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
        }
        .navigationTitle("Enable it to improve security")
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
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func createScreenCells() -> some View {
        VStack {
            HStack() {
                Image(IconsManager.icFirst.image)
                    .frame(width: 24, height: 24)
                Text("Tap on your Apple ID (your name at the top)")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            Text("On your device's home screen, go to Settings and tap the on your Apple ID (your name at the top)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .padding(.bottom, 4)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icSecond.image)
                    .frame(width: 24, height: 24)
                Text("Find My")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Text("Select “Find My”")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(FontsManager.SFRegular.font, size: 14))
                .foregroundColor(ColorManager.textSubtitleDefaultColor.color)
                .padding(.bottom, 4)
            
            HStack(spacing: 10) {
                Image(IconsManager.icFindMySmall.image)
                    .frame(width: 24, height: 24)
                Text("Find My")
                    .font(.custom(FontsManager.SFRegular.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Separator()
                .padding(.bottom, 16)
            
            HStack(spacing: 10) {
                Image(IconsManager.icThird.image)
                    .frame(width: 24, height: 24)
                Text("Enable")
                    .font(.custom(FontsManager.SFSemibold.font, size: 14))
                    .foregroundColor(ColorManager.textDefaultColor.color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 12)
            
            Image(IconsManager.icFindMyTutorial.image)
                .frame(maxWidth: .infinity)
                .background(Color.clear)
                .cornerRadius(10)
                .padding(.bottom, 16)

        }
    }
}

#Preview {
    FindMyScreen()
}
