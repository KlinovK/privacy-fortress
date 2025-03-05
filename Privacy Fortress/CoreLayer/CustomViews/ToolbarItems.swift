//
//  ToolbarItems.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import SwiftUI

struct AddButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("Add")
                .font(.custom(FontsManager.SFRegular.font, size: 17))
                .foregroundColor(ColorManager.textBlueColor.color)
        }
    }
}
