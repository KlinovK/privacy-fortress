//
//  HotizontalProgress.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct HorizontalProgressView: View {
    
    var progress: Double
    private let barWidth: CGFloat = 234
    private let barHeight: CGFloat = 6
    private let cornerRadius: CGFloat = 25
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                backgroundBar
                progressBar
            }
            .frame(width: barWidth, height: barHeight)
        }
    }
}

// MARK: - Subviews

private extension HorizontalProgressView {
    
    /// Background bar (gray)
    
    var backgroundBar: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.3))
            .frame(height: barHeight)
    }
    
    /// Progress bar (green) with animation
    
    var progressBar: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.green)
            .frame(width: progress * barWidth, height: barHeight)
            .animation(.easeInOut(duration: 1), value: progress)
    }
}
