//
//  SplashScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isAnimated = false
    @State private var topIconIsHidden = true
    @State private var bottomIconIsHidden = true
    @State private var logoSize: (CGFloat, CGFloat) = (224, 270)
    
    var body: some View {
        if isAnimated {
            StartScreenView()
        } else {
            VStack {
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 86)
                    .padding(.bottom, 44)
                    .opacity(topIconIsHidden ? 0 : 1)
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize.0, height: logoSize.1)
                    .padding(.bottom, 44)
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 86)
                    .opacity(bottomIconIsHidden ? 0 : 1)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]),
                                       startPoint: .top,
                                       endPoint: .bottom))
            .ignoresSafeArea()
            .onAppear {
                animateIcons()
            }
        }
    }
    
    func animateIcons() {
        withAnimation(.easeOut(duration: 0.5).delay(0.5)) {
            topIconIsHidden = false
        }
        withAnimation(.easeOut(duration: 0.5).delay(1.0)) {
            topIconIsHidden = true
            bottomIconIsHidden = false

        }
        withAnimation(.easeOut(duration: 0.5).delay(1.5)) {
            topIconIsHidden = false
            bottomIconIsHidden = true
        }
        withAnimation(.easeOut(duration: 0.5).delay(2.0)) {
            topIconIsHidden = true
            bottomIconIsHidden = false
        }
        
        withAnimation(.easeInOut(duration: 0.5).delay(2.5)) {
            topIconIsHidden = true
            bottomIconIsHidden = true
            logoSize = (299, 360)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation() {
                isAnimated = true
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
