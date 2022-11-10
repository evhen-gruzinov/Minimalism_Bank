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
    @State var accountTransactions: [Transaction]?
    
    var body: some Scene {
        WindowGroup {
            MainScreen(accountBalance: accountBalance, transactions: accountTransactions)
                .onAppear {
                    Account().getBalance(completion: { balance in
                        accountBalance = balance
                    })
                    Account().getTransactions(count: 5, completion: { transactions in
                        accountTransactions = transactions
                    })
                }
        }
    }
}
