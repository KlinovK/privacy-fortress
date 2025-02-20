//
//  AnalyzingCardView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct AnalyzingCardView: View {
    
    let title: String
    let subtitle: String
    let imageName: String
    var progress: CGFloat
    
    @State var type: StartScreenIssueType = .wifiSecurity

    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white
                .frame(height: type == .systemSecurity ? 101 : 77)
                .cornerRadius(16)

            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding()
                .foregroundColor(progress < 1 ? Color.gray : ColorManager.buttonActiveColor.color)
              
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.custom(FontsManager.SFbold.font, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HorizontalProgressView(progress: progress)
                        .frame(alignment: .leading)
                    
                    Text(subtitle)
                        .font(.custom(FontsManager.SFbold.font, size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .frame(maxWidth: 234, alignment: .leading)
                }
                
                Spacer()
                
                ZStack {
                    if progress < 1 {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    } else {
                        Image(IconsManager.icCheckmark.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding(EdgeInsets(top: 14, leading: 64, bottom: 14, trailing: 16))
            
        }
        .frame(maxWidth: .infinity)
        
    }
}
