//
//  Created by Evhen Gruzinov on 11.11.2022.
//

import SwiftUI

struct TransactionsBlockView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var allTransactionViewOn = false
    var accountData: Account?
    var sessionData: Session
    var backgroundColor: Color { colorScheme == .light ? Color.white : Color.lightDark }

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
                if let transactions = accountData?.transactions {
                    if transactions.count > 0 {
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                            if transaction.id != transactions.last?.id {
                                Divider()
                            }
                        }
                        if let transactionsCount = accountData?.transactionsCount {
                            if transactionsCount > 5 {
                                NavigationLink(isActive: $allTransactionViewOn) {
                                    AllTransactionsScreen(sessionData: sessionData)
                                } label: {
                                    Button { allTransactionViewOn.toggle() } label: {
                                        VStack {
                                            Divider()
                                            HStack {
                                                Text("All transactions").bold()
                                                Image(systemName: "chevron.forward")
                                            }
                                        }
                                    }.foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                }
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
                accountData: Account(balance: 567855, transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .outcome, state: .performed)]),
                sessionData: Session(token: "PRv7xXESmpRdr8")
        )
    }
}