//
//  HotizontalProgress.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct HorizontalProgressView: View {
    
    @State private var progress: CGFloat = 0.0
    
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
        .onAppear() {
            startProgress()
        }
    }
    
    func startProgress() {
        withAnimation {
            for i in 1...100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                    progress = CGFloat(i) / 100
                }
            }
        }
    }
}

struct HorizontalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressView()
    }
}
