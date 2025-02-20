//
//  ResultsScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct ResultsScreen: View {
    
    @State private var viewState: ResultsScreenViewState = .issuesNotFound
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                updatedHeaderView()
                
                NavigationLink(destination: PaywallScreen()) {
                    Text("Resolve All Issues")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 0))
            }
            
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
            .background(Color.gray.opacity(0.1))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func changeState(state: ResultsScreenViewState) {
        viewState = state
    }
    
    private func setupResultsCardViews() -> some View {
        VStack(spacing: 12) {
            ResultCardViewView(title: "Wi-Fi Security", subtitle: "Ensure your Wi-Fi connection is safe and secure", imageName: "swift")
            ResultCardViewView(title: "Personal Data Protection", subtitle: "Monitor and protect your personal information", imageName: "iphone")
            ResultCardViewView(title: "System Security", subtitle: "Check your device settings for optimal security", imageName: "waveform.path.ecg")
            ResultCardViewView(title: "Safe Storage", subtitle: "Securely store your media and passwords.", imageName: "waveform.path.ecg")
        }
        .padding(.top, 24)
    }
    
    private func updatedHeaderView() -> some View {
        VStack(spacing: 12) {
            switch viewState {
            case .issuesNotFound:
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 116)
                Text("Issues not found")
                Text("Your device is fully protected and secure!")
                setupResultsCardViews()
            case .issuesFound:
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 116, height: 116)
                Text("8 issues found")
                Text("Resolve issues to optimize your device's security.")
                setupResultsCardViews()
            }
        }
    }
}

#Preview {
    ResultsScreen()
}


struct ResultCardViewView: View {
    
    let title: String
    let subtitle: String
    let imageName: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .frame(height: 164)
                .cornerRadius(16)

            HStack(spacing: 5.5) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                Text(title)
                    .font(.headline)
            }
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 0))
            
            VStack(spacing: 12) {
                HStack {
                    Text(title)
                        .font(.system(size: 12, weight: .light))
                    Spacer()
                    BadgeView()
                }
                
                HStack {
                    Text(title)
                        .font(.system(size: 12, weight: .light))
                    Spacer()
                    BadgeView()
                }
            }
            .padding(EdgeInsets(top: 72, leading: 16, bottom: 0, trailing: 16))


        }
        .frame(maxWidth: .infinity)
        
    }
}
