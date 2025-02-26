//
//  DataBreachesCheckScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import SwiftUI

struct DataBreachesCheckScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var dataBreackesViewState: DataBreachesCheckViewState = .checking
    @StateObject private var viewModel = DataBreachesCheckViewModel()
    @State private var navigateToResult = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                switch dataBreackesViewState {
                case .checking:
                    createDataBreackesCheckView(geometry: geometry)
                case .notDetected:
                    createNotDetectedDataBreackesCheckView(geometry: geometry)
                }
            }
            .scrollIndicators(.hidden)
            .background(ColorManager.mainBackground.color)
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
    
    private func createNotDetectedDataBreackesCheckView(geometry: GeometryProxy) -> some View {
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
                Text("No data breaches were detected. ")
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

        }
        .padding(.top, Constants.isIPad ? 367 : 40)
        .padding(.horizontal, Constants.isIPad ? 190 : 16)
        .frame(height: geometry.size.height)
    }
    
    private func createDataBreackesCheckView(geometry: GeometryProxy) -> some View {
        VStack {
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
                        .padding(10)
                }
                .background(Color.white)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(ColorManager.textFieldBorderColor.color, lineWidth: 1)
                )
                .cornerRadius(10)
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    let isDataBreachesDetected = await viewModel.startDataBreachesCheck()
                    if isDataBreachesDetected {
                        navigateToResult = true
                    } else {
                        dataBreackesViewState = .notDetected
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
                LeaksListScreen()
            }

        }
        .padding(.top, Constants.isIPad ? 284 : 40)
        .padding(.horizontal, Constants.isIPad ? 284 : 16)
        .frame(height: geometry.size.height)
    }
}

#Preview {
    DataBreachesCheckScreen()
}
