//
//  ContentView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct MainScreen: View {
    var accountData: Account?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.lightDark.ignoresSafeArea()
            } else {
                Color(red: 0.95, green: 0.95, blue: 0.95).ignoresSafeArea()
            }
            ScrollView {
                BalanceBlockView(accountBalance: accountData?.balance)
                TransactionsBlockView(transactions: accountData?.transactions)
                Spacer()
            }.padding()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainScreen(
                accountData: Account(balance: 567855, transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .outcome, state: .performed)])
            )
                .environment(\.colorScheme, .light)
            
            MainScreen(
                accountData: Account(balance: 567855, transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .outcome, state: .performed)])
            )
                .environment(\.colorScheme, .dark)
        }
    }
}
