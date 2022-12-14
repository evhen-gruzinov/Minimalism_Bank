//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct MainScreen: View {
    @Binding var accountData: Account?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black.ignoresSafeArea()
            } else {
                Color(red: 0.95, green: 0.95, blue: 0.95).ignoresSafeArea()
            }
            VStack {
                NoInternetView(disappear: {self.updateData()})
                ScrollView {
                    PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                        updateData()
                    }
                    BalanceBlockView(accountBalance: accountData?.balance)
                    TransactionsBlockView(transactions: accountData?.transactions)
                    Spacer()
                }
                    .padding()
                    .coordinateSpace(name: "pullToRefresh")
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        let testAccountData = Account(balance: 567855, transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .outcome, state: .performed)])
        Group {
            MainScreen(
                accountData: .constant(testAccountData)
            )
            .environment(\.locale, .init(identifier: "en"))
            MainScreen(
                accountData: .constant(testAccountData)
            )
            .environment(\.locale, .init(identifier: "uk"))
        }
    }
}

extension MainScreen {
    func updateData() {
        NetworkManager().getAccountData(userToken: "PRv7xXESmpRdr8", needBalance: true, needTransactions: true, transactionsCount: 5) { data in
            accountData = data
        }
    }
}
