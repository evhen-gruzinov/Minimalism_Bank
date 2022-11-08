//
//  SimpleBankApp.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

@main
struct SimpleBankApp: App {    
    //var accountBalance: Double = 1234.00 .rounded(toPlaces: 2)
//    var accountBalance: Double = Double(UserData().getAccountBalance())
    @State var accountBalance: Int = 0
    
    var body: some Scene {
        WindowGroup {
            MainScreen(accountBalance: accountBalance)
                .onAppear(perform: {
                    UserData().getAccountBalance { accountBalance in
                        self.accountBalance = accountBalance
                    }
                })
        }
    }
}
