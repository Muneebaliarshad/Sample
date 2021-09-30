//
//  BaseViewModel.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation


typealias updateLoadingStatus = (_ status: Bool) -> Void
typealias showAlertClosure = (_ message: String) -> Void
typealias didFinishFetch = () -> Void

struct BrokenRule {
    var propertyName :String
    var message :String
}

protocol ViewModelProtocol {
    var brokenRules :[BrokenRule] { get set}
    var isValid :Bool { mutating get }
}


class BaseViewModel {
    // MARK: - Properties
    var error: String? {
        didSet { self.showAlertClosure?(error ?? "") }
    }
    var isLoading: Bool = false {
        didSet { self.loadingStatus?(isLoading) }
    }
    var infoMessage = ""
    
    
    // MARK: - Closures for callback
    var loadingStatus : updateLoadingStatus?
    var showAlertClosure : showAlertClosure?
    var didFinishFetch : didFinishFetch?
    
    
    func apiRequest() {
    }
}
