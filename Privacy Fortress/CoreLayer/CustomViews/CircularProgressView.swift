//
//  CircularProgressView.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import SwiftUI

struct CircularProgressView: View {
    @State private var progress: CGFloat = 0.0
    @State private var viewState: ViewState = .idle
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 6)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .foregroundColor(Color.green)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: 1), value: progress)
                ZStack {
                    Image(systemName: imageNameForState(viewState))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 91, height: 114)
                    Text("\(Int(progress * 100))%")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(viewState == .success ? .clear : .white)
                }
            }
            .padding()
            
        }
        .onAppear {
            startProgress()
        }
        .padding()
    }
    
    private func startProgress() {
        viewState = .loading
        withAnimation {
            // Increment progress over time (for demo purpose)
            for i in 1...100 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                    progress = CGFloat(i) / 100
                    if progress >= 1 {
                        viewState = .success
                    }
                }
            }
        }
    }
    
    private func imageNameForState(_ state: ViewState) -> String {
        switch state {
        case .idle:
            return "applelogo"
        case .loading:
            return "applelogo"
        case .success:
            return "applelogo"
        case .failure:
            return "applelogo"
        }
    }
    
    enum ViewState {
        case idle, loading, success, failure
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
