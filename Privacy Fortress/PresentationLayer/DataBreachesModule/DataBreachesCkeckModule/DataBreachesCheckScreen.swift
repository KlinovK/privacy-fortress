//
//  DataBreachesCheckScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

import SwiftUI

struct DataBreachesCheckScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = DataBreachesCheckViewModel()
    @StateObject private var keyboardObserver = KeyboardObserver()
    @State private var navigateToResult = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollProxy in
                ScrollView {
                    switch viewModel.state {
                    case .checking:
                        createDataBreachesCheckView(geometry: geometry, scrollProxy: scrollProxy)
                    case .notDetected:
                        createNotDetectedDataBreachesCheckView(geometry: geometry)
                    }
                }
                .scrollIndicators(.hidden)
                .background(ColorManager.mainBackground.color)
                .padding(.bottom, 0)
                .onChange(of: keyboardObserver.height) { newHeight in
                    if newHeight > 0 {
                        withAnimation {
                            scrollProxy.scrollTo("emailTextField", anchor: .bottom)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationTitle("Data Breach Monitoring")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
    
    private func createNotDetectedDataBreachesCheckView(geometry: GeometryProxy) -> some View {
        VStack {
            Image(IconsManager.icAppLogoStartScreen.image)
                .resizable()
                .scaledToFit()
                .frame(width: 114, height: 138)
                .padding(.bottom, 20)
            Text("Great news!")
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorManager.buttonActiveColor.color)
                .font(.custom(FontsManager.SFbold.font, size: 28))
            Text("No data breaches were detected.")
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorManager.buttonActiveColor.color)
                .font(.custom(FontsManager.SFSemibold.font, size: 24))
                .padding(.bottom, 12)
            Text("Your accounts and personal information are safe. Keep monitoring to stay protected.")
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorManager.textDefaultColor.color)
                .font(.custom(FontsManager.SFRegular.font, size: 18))
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)
            Spacer()
        }
        .padding(.top, Constants.isIPad ? 367 : 40)
        .padding(.horizontal, Constants.isIPad ? 190 : 16)
    }
    
    private func createDataBreachesCheckView(geometry: GeometryProxy, scrollProxy: ScrollViewProxy) -> some View {
        VStack {
            Text("Protect Your Data from \n Breaches")
                .frame(maxWidth: .infinity)
                .foregroundColor(ColorManager.buttonActiveColor.color)
                .font(.custom(FontsManager.SFSemibold.font, size: 24))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            Image(IconsManager.icDataBreachesLogo.image)
                .resizable()
                .scaledToFit()
                .frame(width: 154, height: 363)
                .padding(.bottom, 16)
            
            Text("Email Address")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(ColorManager.textDefaultColor.color)
                .font(.custom(FontsManager.SFSemibold.font, size: 18))
                .padding(.bottom, 6)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.gray)
                    .padding(.leading, 12)
                TextField("Enter your email", text: $viewModel.email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(ColorManager.textDefaultColor.color)
                    .font(.custom(FontsManager.SFSemibold.font, size: 18))
                    .padding(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .id("emailTextField")
                    .submitLabel(.done)
                    .onTapGesture {
                        withAnimation {
                            scrollProxy.scrollTo("emailTextField", anchor: .bottom)
                        }
                    }
                    .onSubmit {
                        withAnimation {
                            scrollProxy.scrollTo("emailTextField", anchor: .bottom)
                        }
                    }
            }
            .background(Color.white)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
            )
            .cornerRadius(10)
            
            Spacer()
            Button(action: {
                Task {
                    let breaches = await viewModel.geDataBreaches()
                    if !breaches.isEmpty {
                        navigateToResult = true
                    } else {
                        viewModel.state = .notDetected
                    }
                }
            }) {
                Text("Check")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.custom(FontsManager.SFSemibold.font, size: 20))
                    .background(ColorManager.buttonActiveColor.color)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .navigationDestination(isPresented: $navigateToResult) {
                LeaksListScreen(breaches: viewModel.breaches)
            }
        }
        .padding(.top, Constants.isIPad ? 284 : 40)
        .padding(.horizontal, Constants.isIPad ? 284 : 16)
        .padding(.bottom, 20)
    }
}


#Preview {
    DataBreachesCheckScreen()
}
