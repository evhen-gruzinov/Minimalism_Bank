//
//  TransactionView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 09.11.2022.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5.0) {
                Text(transaction.title)
                    .fontWeight(.bold)
                    .font(.title2)
                Text((transaction.category?.rawValue)?.capitalized ?? "Unknow")
                Text(transaction.dateStr)
            }
            Spacer()
            Text(Formating().moneyFormating(moneyValue: transaction.amount))
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(
            transaction: Transaction(id: 1, userId: 1, accountId: 1, amount: 12345, title: "Apple", dateStr: "9 Nov", category: .electronic, type: .outcome, state: .performed)
        )
            .previewLayout(.sizeThatFits)
    }
}
