//
//  StartCardViewView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct StartCardViewView: View {
    
    let title: String
    let subtitle: String
    let imageName: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .frame(height: 109)
                .cornerRadius(16)

            HStack(alignment: .top) {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.top, 14)
                    .foregroundColor(ColorManager.buttonActiveColor.color)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.custom(FontsManager.SFbold.font, size: 18))
                        .frame(alignment: .leading)
                    Text(subtitle)
                        .font(.custom(FontsManager.SFbold.font, size: 18))
                        .foregroundColor(.gray)
                        .frame(alignment: .leading)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 16)
        }
        
        .frame(maxWidth: .infinity)
        
    }
}
