//
//  TransactionsBlockView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 11.11.2022.
//

import SwiftUI

struct TransactionsBlockView: View {
    @Environment(\.colorScheme) var colorScheme
    var transactions: [Transaction]?
    var backgroundColor: Color {
        if colorScheme == .light { return Color.white } else { return Color.lightDark }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("recentTransactions")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, 25)
            VStack {
                if let transactions = transactions {
                    if transactions.count > 0 {
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                            if transaction.id != transactions.last?.id {
                                Divider()
                            }
                        }
                    } else {
                        Text("You don't have transactions yet")
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(15)
        }
    }
}

struct TransactionsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsBlockView(
            transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .income, state: .performed)]
        )
    }
}
