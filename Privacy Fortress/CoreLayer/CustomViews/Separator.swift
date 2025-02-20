//
//  Separator.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct Separator: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray)
            .opacity(0.5)
            .padding(.bottom, 16)
    }
}

#Preview {
    Separator()
}
