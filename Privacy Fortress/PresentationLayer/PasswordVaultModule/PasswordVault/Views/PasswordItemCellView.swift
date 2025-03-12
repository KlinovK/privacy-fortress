//
//  PasswordItemCellView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 10/03/25.
//

import SwiftUI

struct PasswordItemCellView: View {
    
    @State private var isPasswordVisible = false
    @State private var isSheetPresented = false
    var onCopy: (() -> Void)?
    var onDelete: ((PasswordItem) -> Void)?
    var onEdit: ((PasswordItem) -> Void)?

    let item: PasswordItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Text(item.domain)
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                    .lineLimit(1)
                
                Spacer()
                Button(action: {
                    isSheetPresented = true
                }) {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .foregroundColor(.black)
                        
                }
            }
            .padding(.bottom, 16)
            HStack(spacing: 18) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Username:")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 12))
                    
                    Text(item.username)
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Password:")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 12))
                    
                    HStack {
                        Text(isPasswordVisible ? item.password : "•••••••••••••")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFbold.font, size: 14))
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                        Button(action: { isPasswordVisible.toggle() }) {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(.black)
                        }
                        .frame(height: 0)
                    }

                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 126)
        .background(Color.white)
        .cornerRadius(16)
        .sheet(isPresented: $isSheetPresented) {
            ActionSheetView(item: item, onCopyUsername: { onCopy?() }, onCopyPassword: { onCopy?()
            }, onDelete: {
                onDelete?(item)
            }, onEdit: {
                onEdit?(item)
            })
            .presentationDetents([.height(448)])
            .presentationDragIndicator(.visible)
            .background(ColorManager.actionSheetColor.color)
        }
    }
}

#Preview {
    PasswordItemCellView(
        item: PasswordItem(
            domain: "facebook.com",
            username: "user@example.com",
            password: "SecurePassword123"
        )
    )
}
