//
//  SubscriptionAlertView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 27/02/25.
//

import SwiftUI

struct SubscriptionAlertView: View {
    
    @Binding var isPresented: Bool
    var onDismiss: ((Bool) -> Void)?
    
    @State private var scaleEffect: CGFloat = 0.8
    @State private var opacity: Double = 0.0

    var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack(spacing: 0) {
                    Image(IconsManager.icSubscriptionAlert.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 44)
                        .padding(.bottom, 15)

                    Text("No Access")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFbold.font, size: 17))
                        .padding(.bottom, 4)

                    Text("You need a subscription to access this feature.")
                        .foregroundColor(ColorManager.textDefaultColor.color)
                        .font(.custom(FontsManager.SFRegular.font, size: 13))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 21)

                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                        Button(action: {
                            closeAlert(subscriptionWasPressed: true)
                        }) {
                            HStack {
                                Image(systemName: "checkmark.shield")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(ColorManager.textBlueColor.color)
                                
                                Text("Subscription")
                                    .foregroundColor(ColorManager.textBlueColor.color)
                                    .font(.custom(FontsManager.SFSemibold.font, size: 17))
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(height: 44)
                        Rectangle()
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                            .frame(height: 1)
                        Button(action: {
                            closeAlert()
                        }) {
                            Text("Close")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(ColorManager.textBlueColor.color)
                                .cornerRadius(8)
                                .font(.custom(FontsManager.SFRegular.font, size: 17))
                        }
                        .frame(height:44)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 19)
                .background(ColorManager.mainBackground.color)
                .cornerRadius(14)
                .shadow(radius: 1)
                .frame(maxWidth: 270)
                .scaleEffect(scaleEffect)
                .opacity(opacity)
                .animation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0), value: isPresented)
                .onAppear {
                    withAnimation {
                        scaleEffect = 1.0
                        opacity = 1.0
                    }
                }
                .onDisappear {
                    withAnimation {
                        scaleEffect = 0.8
                        opacity = 0.0
                    }
                }
            }
        }
        
    }
    
    private func closeAlert(subscriptionWasPressed: Bool = false) {
        withAnimation {
            scaleEffect = 0.8
            opacity = 0.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
            onDismiss?(subscriptionWasPressed)
        }
    }
}

#Preview {
    SubscriptionAlertView(isPresented: .constant(true))
}
