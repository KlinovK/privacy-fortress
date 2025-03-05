//
//  NoFilesView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import SwiftUI

struct NoFilesView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Image(IconsManager.icNoFilesVector.image)
                        .frame(width: 104, height: 101)
                        .padding(.horizontal, Constants.isIPad ? 62 : 50)
                }
                Spacer()
            }
            VStack {
                Image(IconsManager.icNothingFound.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 164, height: 159)
                    .padding(.bottom, 32)
                Text("Nothing found")
                    .font(.custom(FontsManager.SFSemibold.font, size: 28))
                    .foregroundColor(ColorManager.attentionTextColor.color)
                    .padding(.bottom, 12)
                Text("You haven’t added any media to the secret folder yet")
                    .font(.custom(FontsManager.SFRegular.font, size: 18))
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, Constants.isIPad ? 190 : 24)
            .padding(.top, Constants.isIPad ? 411 : 200)
        }
        .padding(.horizontal, Constants.isIPad ? 0 : 0)
        .padding(.top, Constants.isIPad ? 411 : 0)
        .background(Color.white)
    }
}
