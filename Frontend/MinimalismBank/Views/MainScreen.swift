//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct MainScreen: View {
    @Binding var accountData: Account?
    @Binding var sessionData: Session
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                if colorScheme == .dark {
                    Color.black.ignoresSafeArea()
                } else {
                    Color(red: 0.95, green: 0.95, blue: 0.95).ignoresSafeArea()
                }
                VStack {
                    ScrollView {
                        PullToRefresh(coordinateSpaceName: "pullToRefresh") { updateData() }
                        NoInternetView(disappear: { updateData() })
                        BalanceBlockView(accountBalance: accountData?.balance)
                        TransactionsBlockView(accountData: accountData,sessionData: sessionData)
                        Spacer()
                    }
                            .padding()
                            .coordinateSpace(name: "pullToRefresh")
                }
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        let testAccountData = Account(balance: 567855, transactions: [Transaction(id: 4, userId: 1, accountId: 1, amount: 9900, title: "From: Tim Cook", dateStr: "2022-10-23 00:00:00", category: .transfer, type: .outcome, state: .performed)])
        Group {
            MainScreen(
                accountData: .constant(testAccountData),
                sessionData: .constant(Session(token: "PRv7xXESmpRdr8"))
            )
            .environment(\.locale, .init(identifier: "en"))
            MainScreen(
                accountData: .constant(testAccountData),
                sessionData: .constant(Session(token: "PRv7xXESmpRdr8"))
            )
            .environment(\.locale, .init(identifier: "uk"))
        }
    }
}

extension MainScreen {
    func updateData() {
        NetworkManager().getAccountData(userToken: sessionData.token, needBalance: true, needTransactions: true, transactionsCount: 5) { data in
            accountData = data
        }
    }
}
