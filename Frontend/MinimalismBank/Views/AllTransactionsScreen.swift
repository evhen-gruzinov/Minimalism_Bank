//
//  Created by Evhen Gruzinov on 18.11.2022.
//

import SwiftUI

struct AllTransactionsScreen: View {
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color {
        colorScheme == .light ? Color.white : Color.lightDark
    }
    var sessionData: Session
    @State var allTransactions: [Transaction]?

    var body: some View {
        ScrollView {
            NoInternetView(disappear: { updateData() })
            VStack {
                if let transactions = allTransactions {
                    ForEach(transactions) { transaction in
                        TransactionView(transaction: transaction)
                        if transaction.id != transactions.last?.id {
                            Divider()
                        }
                    }
                } else {
                    ProgressView()
                }
            }
                    .padding()
                    .background(backgroundColor)
                    .cornerRadius(15)
        }
                .navigationTitle("allTransactions")
                .onAppear {
                    NetworkManager().getAccountData(userToken: sessionData.token, needBalance: false, needTransactions: true, transactionsCount: 0) { data in
                        allTransactions = data.transactions
                    }
                }
    }
}

struct AllTransactionsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllTransactionsScreen(sessionData: Session(token: "PRv7xXESmpRdr8"))
    }
}

extension AllTransactionsScreen {
    func updateData() {
        NetworkManager().getAccountData(userToken: sessionData.token, needBalance: false, needTransactions: true, transactionsCount: 0) { data in
            allTransactions = data.transactions
        }
    }
}