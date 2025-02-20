//
//  ApphudManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation

//import Apphud

//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    // Initialize Apphud with your API Key
//    Apphud.start(apiKey: "your-apphud-api-key")
//    return true
//}


//import Apphud
//
//// Fetch available products
//Apphud.getProducts { products in
//    for product in products {
//        print("Product: \(product.productId), \(product.price)")
//    }
//}
//
//// Make a purchase
//func purchaseProduct(productId: String) {
//    Apphud.purchase(productId) { result in
//        switch result {
//        case .success(let purchase):
//            // Handle successful purchase
//            print("Purchase successful: \(purchase)")
//        case .failure(let error):
//            // Handle purchase failure
//            print("Purchase failed: \(error.localizedDescription)")
//        }
//    }
//}


//Apphud.isSubscriptionActive { isActive in
//    if isActive {
//        // Subscription is active
//        print("Subscription is active")
//    } else {
//        // Subscription is not active
//        print("Subscription is not active")
//    }
//}


//Apphud.restorePurchases { result in
//    switch result {
//    case .success(let restoredPurchases):
//        // Handle restored purchases
//        print("Restored purchases: \(restoredPurchases)")
//    case .failure(let error):
//        // Handle error
//        print("Restore failed: \(error.localizedDescription)")
//    }
//}
