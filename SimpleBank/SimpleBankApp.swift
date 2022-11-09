//
//  SimpleBankApp.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

@main
struct SimpleBankApp: App {
    @State var accountBalance: Int?
    
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
