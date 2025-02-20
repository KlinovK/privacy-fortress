//
//  StartScreen.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct StartScreenView: View {
    
    @State private var viewState: StartScreenViewState = .start
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    switch viewState {
                    case .start:
                        Image(systemName: "applelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 121, height: 146)
                        Text("Your Privacy & Security Check")
                        startCardViews()
                    case .isAnalyzing:
                        CircularProgressView()
                        Text("Analyzing Your Device...")
                        startAnalyzingCardViews()
                    case .isFinishedAnalyzing:
                        Image(systemName: "applelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 121, height: 146)
                        Text("Analyz has finished")
                        startAnalyzingCardViews()
                    }
                   
                }
                
                switch viewState {
                case .start:
                    Button(action: {
                        changeState(state: .isAnalyzing)
                    }) {
                        Text("Start Scan")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 0))
                case .isAnalyzing:
                    
                    NavigationLink(destination: ResultsScreen()) {
                        Text("View Results")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 0))
                case .isFinishedAnalyzing:
                    Button(action: {
                        changeState(state: .isAnalyzing)
                    }) {
                        Text("View Results")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    .padding(EdgeInsets(top: 22, leading: 0, bottom: 24, trailing: 0))
                }
                
           
            }
            
            .scrollIndicators(.hidden)
            .padding(.horizontal, 24)
            .background(Color.gray.opacity(0.1))
        
        }
    }
    
    private func changeState(state: StartScreenViewState) {
        viewState = state
    }
    
    private func startCardViews() -> some View {
        VStack(spacing: 12) {
            StartCardViewView(title: "Wi-Fi Security", subtitle: "Ensure your Wi-Fi connection is safe and secure", imageName: "swift")
            StartCardViewView(title: "Personal Data Protection", subtitle: "Monitor and protect your personal information", imageName: "iphone")
            StartCardViewView(title: "System Security", subtitle: "Check your device settings for optimal security", imageName: "waveform.path.ecg")
            StartCardViewView(title: "Safe Storage", subtitle: "Securely store your media and passwords.", imageName: "waveform.path.ecg")
        }
    }
    
    private func startAnalyzingCardViews() -> some View {
        VStack(spacing: 12) {
            StartAnalyzingCardViewView(title: "Wi-Fi Security", subtitle: "", imageName: "swift", progress: 100)
            StartAnalyzingCardViewView(title: "Personal Data Protection", subtitle: "", imageName: "iphone", progress: 100)
            StartAnalyzingCardViewView(title: "System Security", subtitle: "Internal storage/addon/system file.idf", imageName: "waveform.path.ecg", progress: 100)
            StartAnalyzingCardViewView(title: "Safe Storage", subtitle: "", imageName: "waveform.path.ecg", progress: 100)
        }
    }
}

#Preview {
    StartScreenView()
}


struct StartCardViewView: View {
    
    let title: String
    let subtitle: String
    let imageName: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color.white
                .frame(height: 109)
                .cornerRadius(16)

            HStack(alignment: .top) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 16)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .frame(alignment: .leading)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(alignment: .leading)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
            }
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity)
        
    }
}

struct StartAnalyzingCardViewView: View {
    
    let title: String
    let subtitle: String
    let imageName: String
    let progress: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            
            Color.white
                .frame(height: 109)
                .cornerRadius(16)

            HStack(alignment: .center) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 15)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .frame(alignment: .leading)
                    
                    HorizontalProgressView()
                        .frame(alignment: .leading)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .frame(maxWidth: 234, alignment: .leading)
                }
                .padding(.top, 14)
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 16)
        }
        .frame(maxWidth: .infinity)
        
    }
}
