//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

@main
struct MinimalismBankApp: App {
    @State var accountData: Account?

    var body: some Scene {
        WindowGroup {
            MainScreen(accountData: $accountData)
                .onAppear {
                    NetworkManager().getAccountData(userToken: "PRv7xXESmpRdr8", needBalance: true, needTransactions: true, transactionsCount: 5) { data in
                        accountData = data
                    }
                }
        }
    }
}
