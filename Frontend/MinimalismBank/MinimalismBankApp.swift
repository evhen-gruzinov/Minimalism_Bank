//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

@main
struct MinimalismBankApp: App {
    @State var accountData: Account?
    @State var sessionData = Session(token: "PRv7xXESmpRdr8")

    var body: some Scene {
        WindowGroup {
            MainScreen(accountData: $accountData, sessionData: $sessionData)
                .onAppear {
                    NetworkManager().getAccountData(userToken: sessionData.token, needBalance: true, needTransactions: true, transactionsCount: 5) { data in
                        accountData = data
                    }
                }
        }
    }
}
