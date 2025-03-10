//
//  ActionSheetView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 09/03/25.
//

import SwiftUI

struct ActionSheetView: View {
    
    let item: PasswordItem
    @Environment(\.dismiss) var dismiss
    var onCopyUsername: (() -> Void)?
    var onCopyPassword: (() -> Void)?
    var onDelete: (() -> Void)?
    var onEdit: (() -> Void)?

    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Text("Manage Your Password")
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(IconsManager.icCloseActionSheet.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.bottom, 38)
            
            Text("\(item.domain)")
                .foregroundColor(ColorManager.textDefaultColor.color)
                .font(.custom(FontsManager.SFSemibold.font, size: 24))
                .padding(.bottom, 31)
            
            VStack(spacing: 10) {

                Button(action: {
                    UIPasteboard.general.string = item.username
                    onCopyUsername?()
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "doc.on.doc.fill")
                            .foregroundColor(ColorManager.buttonActiveColor.color)
                        Text("Copy username")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFRegular.font, size: 17))
                        Spacer()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
                }
                
                Button(action: {
                    UIPasteboard.general.string = item.password
                    onCopyPassword?()
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "ellipsis.rectangle.fill")
                            .foregroundColor(ColorManager.buttonActiveColor.color)
                        Text("Copy password")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFRegular.font, size: 17))
                        Spacer()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
                }
                Button(action: {
                    onEdit?()
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .foregroundColor(ColorManager.buttonActiveColor.color)
                        Text("Edit")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFRegular.font, size: 17))
                        Spacer()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
                }

                Button(action: {
                    onDelete?()
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "trash.fill")
                            .foregroundColor(ColorManager.warningTextColor.color)
                        Text("Delete")
                            .foregroundColor(ColorManager.textDefaultColor.color)
                            .font(.custom(FontsManager.SFRegular.font, size: 17))
                        Spacer()
                    }
                    .padding()
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(16)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorManager.actionSheetColor.color)
        .padding(.horizontal, 24)
    }
}

//#Preview {
//    ActionSheetView(item: PasswordItem(domainName: "goodle.co,", username: "username", password: "daskdksaf"))
//}
