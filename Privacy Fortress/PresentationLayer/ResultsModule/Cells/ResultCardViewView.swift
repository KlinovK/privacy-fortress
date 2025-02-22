//
//  ResultCardViewView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 22/02/25.
//

import SwiftUI

struct ResultCardViewView: View {
    
    let title: String
    let firstIssueTitle: String
    let secondIssueTitle: String
    let imageName: String
    let firstIssueType: IssueType
    let secondIssueType: IssueType

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
                .frame(height: 148)
                .cornerRadius(16)
            HStack(spacing: 5.5) {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(Color.black)
                Text(title)                .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
            }
            .padding(EdgeInsets(top: 16, leading: 12, bottom: 0, trailing: 0))
            
            VStack(spacing: 12) {
                HStack {
                    Text(firstIssueTitle)
                        .font(.custom(FontsManager.SFlight.font, size: 14))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    Spacer()
                    BadgeView(issueType: firstIssueType)
                }
                
                HStack {
                    Text(secondIssueTitle)
                        .font(.custom(FontsManager.SFlight.font, size: 14))
                        .foregroundColor(ColorManager.textDefaultColor.color)
                    Spacer()
                    BadgeView(issueType: secondIssueType)
                }
            }
            .padding(EdgeInsets(top: 64, leading: 12, bottom: 0, trailing: 12))


        }
        .frame(maxWidth: .infinity)
        
    }
}

