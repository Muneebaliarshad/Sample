//
//  inAppHelper.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import StoreKit

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void
public typealias PurchaseRequestCompletionHandler = (_ success: Bool, _ message: String) -> Void


extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}


open class IAPHelper: NSObject  {
    
    //MARK: - Variables
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    var purchaseRequestCompletionHandler: PurchaseRequestCompletionHandler?
    
    
    //MARK: - Init Methods
    public init(productIds: Set<ProductIdentifier>) {
        productIdentifiers = productIds
        for productIdentifier in productIds {
            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
            if purchased {
                purchasedProductIdentifiers.insert(productIdentifier)
                printData("Previously purchased: \(productIdentifier)")
            } else {
                printData("Not purchased: \(productIdentifier)")
            }
        }
        
        super.init()
        SKPaymentQueue.default().add(self)
    }
}


// MARK: - StoreKit API
extension IAPHelper {
    
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct) {
        printData("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        if payment.productIdentifier == "" {
            purchaseRequestCompletionHandler?(false, "Try Again, Something went Wrong")
        } else {
            SKPaymentQueue.default().add(payment)
        }
    }
    
    public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
        return purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


// MARK: - SKProductsRequestDelegate
extension IAPHelper: SKProductsRequestDelegate {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        printData("Loaded list of products... \(products.count)")
        products.forEach { (product) in
            printData("Found product: \(product.productIdentifier) \(product.localizedTitle) \(product.price.floatValue)")
            
        }
        
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        printData("Failed to load list of products.")
        printData("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                complete(transaction: transaction)
                break
                
            case .failed:
                fail(transaction: transaction)
                break
                
            case .restored:
                restore(transaction: transaction)
                break
                
            case .deferred:
                break
                
            case .purchasing:
                break
                
            default:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        printData("complete...")
        //        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        purchaseRequestCompletionHandler?(true, "")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        printData("restore... \(productIdentifier)")
        //        deliverPurchaseNotificationFor(identifier: productIdentifier)
        purchaseRequestCompletionHandler?(true, "")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        printData("fail...")
        if let transactionError = transaction.error as NSError?,
           let localizedDescription = transaction.error?.localizedDescription {
            printData("Transaction Error Code: \(transactionError.code)")
            printData("Transaction Error Reason: \(localizedDescription)")
            purchaseRequestCompletionHandler?(false, localizedDescription)
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        
        purchasedProductIdentifiers.insert(identifier)
        UserDefaults.standard.set(true, forKey: identifier)
        NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
    }
}

