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
    @State private var topIcon: String = IconsManager.icWifiSecuritySplash.image
    @State private var bottomIcon: String = IconsManager.icPersonalSataSecuritySplash.image
    
    private let kAnimationDuration: TimeInterval = 0.5
    
    var body: some View {
        if isAnimated {
            StartScreenView()
        } else {
            VStack {
                Image(topIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 86)
                    .padding(.bottom, 44)
                    .hidden(topIconIsHidden)
                Image(IconsManager.appLogo.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoSize.0, height: logoSize.1)
                    .padding(.bottom, 44)
                Image(bottomIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 86, height: 86)
                    .padding(.bottom, 44)
                    .hidden(bottomIconIsHidden)
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color("SplashScreenBackground1"), Color("SplashScreenBackground2")]),
                                       startPoint: .top,
                                       endPoint: .bottom))
            .ignoresSafeArea()
            .onAppear {
                animateIcons()
            }
        }
    }
    
    func animateIcons() {

        withAnimation(.easeOut(duration: kAnimationDuration).delay(0.5)) {
            topIconIsHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeOut(duration: kAnimationDuration)) {
                topIconIsHidden = true
                bottomIconIsHidden = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            topIcon = IconsManager.icSystemSecuritySplash.image
            withAnimation(.easeOut(duration: kAnimationDuration)) {
                topIconIsHidden = false
                bottomIconIsHidden = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            bottomIcon = IconsManager.icPersonalStorageSplash.image
            withAnimation(.easeOut(duration: kAnimationDuration)) {
                topIconIsHidden = true
                bottomIconIsHidden = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: kAnimationDuration)) {
                topIconIsHidden = true
                bottomIconIsHidden = true
                logoSize = (299, 360)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation {
                isAnimated = true
            }
        }
    }}

#Preview {
    SplashScreenView()
}

