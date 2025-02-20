//
//  CircularProgressView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct CircularProgressView: View {
    
    var progress: Double

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 6)
                    .foregroundColor(ColorManager.analyzingCircleBorderColor.color)
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .foregroundColor(ColorManager.buttonActiveColor.color)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: 1), value: progress)

                ZStack {
                    Image(IconsManager.icAnalyzing.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 91, height: 114)

                    Text("\(Int(progress * 100))%")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .background(Color.white)
            .cornerRadius(100)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        }
        .padding()
    }
}
