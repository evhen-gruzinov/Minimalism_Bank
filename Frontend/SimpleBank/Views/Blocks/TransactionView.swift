//
//  TransactionView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import SwiftUI

struct TransactionView: View {
    @Environment(\.colorScheme) var colorScheme
    var transaction: Transaction
    var amountColor: Color {
        if transaction.type == .income { return Color.green }
        else {
            if colorScheme == .light { return Color.black } else { return Color.white }
        }
    }
    var transactionDate: String {
        let date = Formatting().stringToDateFormat(from: transaction.dateStr)
        if let date = date { return date } else { return "" }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(transaction.title)
                        .font(.headline)
                    
                    Text(
                        NSLocalizedString(transaction.category?.rawValue ?? "unknown", comment: "Transaction category")
                    )
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
                Text(transactionDate)
                    .font(.caption)
            }
            Spacer()
            Text((transaction.type == .income ? "+ " : "") + Formatting().intToMoneyFormat(from: transaction.amount))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(amountColor)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(
            transaction: Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .outcome, state: .performed)
        )
            .previewLayout(.sizeThatFits)
    }
}
