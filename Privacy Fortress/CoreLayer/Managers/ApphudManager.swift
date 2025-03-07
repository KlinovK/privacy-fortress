//
//  ApphudManager.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 20/02/25.
//

import Foundation
import StoreKit
import ApphudSDK
import AppTrackingTransparency
import AdSupport

class ApphudManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = ApphudManager()
    
    private lazy var remoteService = RemoteService()
    
    // MARK: - Properties
    
    private var product: SKProduct?
    private var productRequest: SKProductsRequest?
    
    private var purchaseCompletion: ((Result<Bool, Error>) -> Void)?
    
    // MARK: - Initialization
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    func hasActiveSubscription() -> Bool {
        Apphud.hasActiveSubscription()
    }
    
    // MARK: - Setup
    
    @MainActor
    func restorePurchases() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.restorePurchases { purchases, subscriptions, error in
                if let error = error {
                    print("Restore failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let hasActivePurchase = purchases?.contains { $0.isActive() } ?? false
                let hasActiveSubscription = subscriptions?.contains { $0.isActive() } ?? false
                
                if hasActivePurchase || hasActiveSubscription {
                    print("Purchases restored successfully")
                    UserSessionManager.shared.isUserSubscribed = true
                    continuation.resume(returning: true)
                } else {
                    print("No active purchases or subscriptions found to restore")
                    UserSessionManager.shared.isUserSubscribed = false
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    @MainActor
    func setupApphud() async {
        let userID = UserSessionManager.shared.uniqueUserID
        Apphud.start(apiKey: Constants.apphudAPIKey, userID: userID)
        await fetchIDFA()
        Apphud.setDeviceIdentifiers(idfa: nil, idfv: UIDevice.current.identifierForVendor?.uuidString)
        UserSessionManager.shared.updateSubscriptionStatus()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let fetchedProduct = response.products.first {
            self.product = fetchedProduct
            print("Product fetched: \(fetchedProduct.localizedTitle), Price: \(fetchedProduct.price)")
        } else {
            print("No products found.")
        }
    }
    
    @MainActor
    func makePurchase() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.purchase(Constants.productIdentifier) { result in
                if let error = result.error {
                    print("Purchase failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                } else if let subscription = result.subscription, subscription.isActive() {
                    print("Subscription purchased successfully! Status: \(subscription.status)")
                    UserSessionManager.shared.createOriginalTransactionID(subscription.productId)
                    UserSessionManager.shared.isUserSubscribed = true
#warning("Uncomment")
                    AppFlyerManager.shared.sendPurchaseEvent(productId: subscription.productId)
//                    remoteService.sendUserData()
                    continuation.resume(returning: true)
                } else {
                    print("Purchase completed but no active subscription found.")
                    UserSessionManager.shared.isUserSubscribed = false
                    continuation.resume(returning: false)
                }
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchasedTransaction(transaction)
            case .failed:
                handleFailedTransaction(transaction)
            case .restored:
                handleRestoredTransaction(transaction)
            case .deferred:
                print("Purchase deferred.")
            case .purchasing:
                print("Purchasing in progress...")
            @unknown default:
                print("Unknown transaction state.")
            }
        }
    }
    
    // MARK: - Transaction Handlers
    
    private func handlePurchasedTransaction(_ transaction: SKPaymentTransaction) {
        UserSessionManager.shared.isUserSubscribed = true
        SKPaymentQueue.default().finishTransaction(transaction)
        purchaseCompletion?(.success(true))
        purchaseCompletion = nil
    }
    
    private func handleFailedTransaction(_ transaction: SKPaymentTransaction) {
        print("Purchase failed: \(String(describing: transaction.error))")
        SKPaymentQueue.default().finishTransaction(transaction)
        if let error = transaction.error {
            purchaseCompletion?(.failure(error))
        } else {
            purchaseCompletion?(.failure(PurchaseError.unknown))
        }
        purchaseCompletion = nil
    }
    
    private func handleRestoredTransaction(_ transaction: SKPaymentTransaction) {
        UserSessionManager.shared.isUserSubscribed = true
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    @MainActor
    private func fetchIDFA() async {
        if #available(iOS 14.5, *) {
            let status = await ATTrackingManager.requestTrackingAuthorization()
            if status == .authorized {
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                Apphud.setDeviceIdentifiers(idfa: idfa, idfv: UIDevice.current.identifierForVendor?.uuidString)
            }
        }
    }
}


