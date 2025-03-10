//
//  CircularProgressView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct CircularProgressView: View {
    
    var progress: Double
    private let circleSize: CGFloat = 200
    private let lineWidth: CGFloat = 6
    
    var body: some View {
        VStack {
            ZStack {
                backgroundCircle
                progressCircle
                progressContent
            }
            .background(Color.white)
            .cornerRadius(circleSize / 2)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
        }
        .padding()
    }
}

// MARK: - Subviews

private extension CircularProgressView {
    
    /// Background circle with a border
    
    var backgroundCircle: some View {
        Circle()
            .stroke(lineWidth: lineWidth)
            .foregroundColor(ColorManager.analyzingCircleBorderColor.color)
            .frame(width: circleSize, height: circleSize)
    }
    
    /// Progress arc with animation
    
    var progressCircle: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .foregroundColor(ColorManager.buttonActiveColor.color)
            .rotationEffect(.degrees(-90))
            .frame(width: circleSize, height: circleSize)
            .animation(.easeInOut(duration: 1), value: progress)
    }
    
    /// Central image and percentage text
    
    var progressContent: some View {
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
}
