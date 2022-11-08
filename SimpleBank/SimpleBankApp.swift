//
//  SimpleBankApp.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

@main
struct SimpleBankApp: App {
    var moneyBalance:Double = 1234.00 .rounded(toPlaces: 2)
    
    var body: some Scene {
        WindowGroup {
            ContentView(moneyBalance: moneyBalance)
        }
    }
}
