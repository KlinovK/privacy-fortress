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

final class ApphudManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
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
    
    // MARK: - Subscription Status
    
    func hasActiveSubscription() -> Bool {
        Apphud.hasActiveSubscription()
    }
    
    // MARK: - Setup
    
    @MainActor
    func setupApphud() async {
        let userID = UserSessionManager.shared.uniqueUserID
        Apphud.start(apiKey: Constants.apphudAPIKey, userID: userID)
        await fetchIDFA()
        Apphud.setDeviceIdentifiers(idfa: nil, idfv: UIDevice.current.identifierForVendor?.uuidString)
        UserSessionManager.shared.updateSubscriptionStatus()
    }
    
    // MARK: - Restore Purchases
    
    @MainActor
    public func showManageSubscriptions(in scene: UIWindowScene) async throws {

        let subscriptionURL = URL(string: "https://apps.apple.com/account/subscriptions")!

        if #available(iOS 15.0, *) {
            try await AppStore.showManageSubscriptions(in: scene)
        } else {
            await UIApplication.shared.open(subscriptionURL)
        }
    }
    
    @MainActor
    func restorePurchases() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.restorePurchases { purchases, subscriptions, error in
                if let error = error {
                    print("❌ Restore failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                let isActive = (purchases?.contains { $0.isActive() } ?? false) ||
                               (subscriptions?.contains { $0.isActive() } ?? false)
                
                UserSessionManager.shared.isUserSubscribed = isActive
                print(isActive ? "✅ Purchases restored successfully" : "⚠️ No active purchases found to restore")
                continuation.resume(returning: isActive)
            }
        }
    }
    
    // MARK: - Fetch Products
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let fetchedProduct = response.products.first else {
            print("⚠️ No products found.")
            return
        }
        self.product = fetchedProduct
        print("✅ Product fetched: \(fetchedProduct.localizedTitle), Price: \(fetchedProduct.price)")
    }
    
    // MARK: - Purchase Handling
    
    @MainActor
    func makePurchase() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            Apphud.purchase(Constants.productIdentifier) { [weak self] result in
                
                AppFlyerManager.shared.logEvent(name: "purchase_try", productId: Constants.productIdentifier)
                if let error = result.error {
                    print("❌ Purchase failed: \(error.localizedDescription)")
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let subscription = result.subscription, subscription.isActive() else {
                    print("⚠️ Purchase completed but no active subscription found.")
                    UserSessionManager.shared.isUserSubscribed = false
                    continuation.resume(returning: false)
                    return
                }
                self?.handleSuccessfulPurchase(subscription)
                continuation.resume(returning: true)
            }
        }
    }
    
    private func handleSuccessfulPurchase(_ subscription: ApphudSubscription) {
        print("✅ Subscription purchased successfully! Status: \(subscription.status)")
        
        UserSessionManager.shared.createOriginalTransactionID(subscription.productId)
        UserSessionManager.shared.isUserSubscribed = true
        AppFlyerManager.shared.logEvent(name: "purchase_success", productId: subscription.productId)
        
        Task { await remoteService.sendUserData() }
    }
    
    // MARK: - Payment Queue Handling
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handleTransaction(transaction, success: true)
            case .failed:
                handleTransaction(transaction, success: false)
            case .restored:
                handleRestoredTransaction(transaction)
            case .deferred:
                print("⏳ Purchase deferred.")
            case .purchasing:
                print("⏳ Purchasing in progress...")
            @unknown default:
                print("⚠️ Unknown transaction state.")
            }
        }
    }
    
    // MARK: - Transaction Handlers
    
    private func handleTransaction(_ transaction: SKPaymentTransaction, success: Bool) {
        if success {
            print("✅ Purchase completed: \(transaction.payment.productIdentifier)")
            UserSessionManager.shared.isUserSubscribed = true
            purchaseCompletion?(.success(true))
        } else {
            AppFlyerManager.shared.logEvent(name: "purchase_failure", productId: Constants.productIdentifier)
            print("❌ Purchase failed: \(String(describing: transaction.error?.localizedDescription))")
            purchaseCompletion?(.failure(transaction.error ?? PurchaseError.unknown))
        }
        SKPaymentQueue.default().finishTransaction(transaction)
        purchaseCompletion = nil
    }
    
    private func handleRestoredTransaction(_ transaction: SKPaymentTransaction) {
        print("✅ Restored purchase: \(transaction.payment.productIdentifier)")
        UserSessionManager.shared.isUserSubscribed = true
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    // MARK: - IDFA Request
    
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


