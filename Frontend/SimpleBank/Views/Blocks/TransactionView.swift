//
//  TransactionView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    var amountColor: Color {
        if transaction.type == .income {
            return Color.green
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                HStack {
                    Text(transaction.title)
                        //.fontWeight(.bold)
                        .font(.headline)
                    Text((transaction.category?.rawValue)?.capitalized ?? "Unknow")
                        .font(.caption)
                        .italic()
                        .foregroundColor(Color.gray)
                }
                Text(transaction.dateStr)
                    .font(.caption)
            }
            Spacer()
            Text((transaction.type == .income ? "+ " : "") + Formating().moneyFormating(moneyValue: transaction.amount))
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(amountColor)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(
            transaction: Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23", category: .transfer, type: .income, state: .performed)
        )
            .previewLayout(.sizeThatFits)
    }
}
