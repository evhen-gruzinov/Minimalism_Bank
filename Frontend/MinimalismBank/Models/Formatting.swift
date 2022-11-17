//
//  Formatting.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import Foundation

class Formatting {
    func intToMoneyFormat(from moneyValue: Int) -> String {
        let moneyValueDouble: Double = Double(moneyValue) / 100
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en-US")
        
        let formattedString = currencyFormatter.string(from: NSNumber(value: moneyValueDouble))!
        return formattedString
    }
    
    func stringToDateFormat(from date:String) -> String? {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from:date)!
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let finalDate = calendar.date(from:components)
        
        guard let finalDate = finalDate else {return nil}
        
        let nowYear = calendar.component(.year, from: Date())
        let dateYear = calendar.component(.year, from: date)
        
        let returnDateFormatter = DateFormatter()

        #if DEBUG
        returnDateFormatter.locale = Locale(identifier: "en-US")
        #endif
        
        if nowYear == dateYear {
            returnDateFormatter.dateFormat = "d MMM"
        } else {
            returnDateFormatter.dateFormat = "d MMM YYYY"
        }
        
        let dateStr = returnDateFormatter.string(from: finalDate)
        
        return dateStr
    }
}
