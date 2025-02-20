//
//  HotizontalProgress.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct HorizontalProgressView: View {
    
    var progress: Double

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 6)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.green)
                    .frame(width: progress * 234, height: 6)
                    .animation(.easeInOut(duration: 1), value: progress)
            }
            .frame(width: 234, height: 6)
        }
    }
}

