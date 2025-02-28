//
//  DataBreachesCheckViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import Foundation

@MainActor
class DataBreachesCheckViewModel: ObservableObject {
    
    @Published var state: DataBreachesCheckViewState = .checking
    @Published var email: String = ""
    @Published var breaches: [Breach] = []
    
    private let personalDataProtectionManager: PersonalDataProtectionManagerProtocol
    
    init(personalDataProtectionManager: PersonalDataProtectionManagerProtocol = PersonalDataProtectionManager()) {
        self.personalDataProtectionManager = PersonalDataProtectionManager()
    }
        
    func geDataBreaches() async -> [Breach] {
        let foundBreaches = await personalDataProtectionManager.checkDataBreach(for: email, isItFirstLaunch: false)
        DispatchQueue.main.async {
            self.breaches = foundBreaches
        }
        return foundBreaches
    }
    
}
