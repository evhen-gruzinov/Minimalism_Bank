//
//  ContentView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct MainScreen: View {
    var accountBalance: Int?
    var transactions: [Transaction]?
    
    var body: some View {
        ZStack {
            Color(red: 0.949, green: 0.949, blue: 0.949).ignoresSafeArea()
            ScrollView {
                BalanceView(accountBalance: accountBalance)
                
                HStack {
                    Text("Recent transactions:")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top, 25)
                VStack {
                    if let transactions = transactions {
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                            if transaction.id != transactions.last?.id {
                                Divider()
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                Spacer()
            }.padding()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(
            accountBalance: 567855,
            transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .income, state: .performed)]
        )
    }
}
