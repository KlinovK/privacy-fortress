//
//  BadgeView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct BadgeView: View {
    
    var body: some View {
        HStack {
            Text("SwiftUI Dynamic")
                .font(.system(size: 12, weight: .light))
                .fixedSize()
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.yellow)

          
        }
        .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 8))
        .background(Color.gray.opacity(0.2))
        .cornerRadius(24)
    }
}

#Preview {
    BadgeView()
}
