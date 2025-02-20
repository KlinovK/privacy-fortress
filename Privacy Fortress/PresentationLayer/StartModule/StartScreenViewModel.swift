//
//  StartScreenViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

@MainActor
class StartScreenViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var progress: Double = 0.0
    @Published var isRequestComplete = false

    func startMockRequest() async {
        isLoading = true
        progress = 0.0
        isRequestComplete = false

        let randomDelay = Double.random(in: 2.0...5.0)

        for i in 1...100 {
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress = Double(i) / 100.0
        }

        try? await Task.sleep(nanoseconds: UInt64(randomDelay * 1_000_000_000)) 

        isLoading = false
        isRequestComplete = true
        progress = 1.0
    }
}
