//
//  Formating.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import Foundation

class Formating {
    func moneyFormating(moneyValue: Int) -> String {
        let moneyValueDouble: Double = Double(moneyValue) / 100
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en-US")
        
        let formatedString = currencyFormatter.string(from: NSNumber(value: moneyValueDouble))!
        return formatedString
    }
}
