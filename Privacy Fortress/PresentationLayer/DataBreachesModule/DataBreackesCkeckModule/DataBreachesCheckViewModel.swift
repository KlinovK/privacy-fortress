//
//  DataBreachesCheckViewModel.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 26/02/25.
//

import Foundation

@MainActor
class DataBreachesCheckViewModel: ObservableObject {
    
    @Published var email: String = ""
    
    private let dataBreachesManager: PersonalDataProtectionManagerProtocol
    
    init(dataBreachesManager: PersonalDataProtectionManagerProtocol = PersonalDataProtectionManager()) {
        self.dataBreachesManager = PersonalDataProtectionManager()
    }
    
    func startDataBreachesCheck() async -> Bool {
        let dataBreachesWasFound = await dataBreachesManager.checkDataBreach(for: email)
        return true
    }
    
}
