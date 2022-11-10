//
//  BalanceView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct BalanceView: View {
    var accountBalance: Int?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Balance")
                Text(accountBalance != nil ? Formating().moneyFormating(moneyValue: accountBalance!) : "Loading...")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            
            Button("Transactions") {

            }
            .foregroundColor(Color.white)
            .font(Font.headline.weight(.bold))
            .padding(10)
            .background(Color.black)
            .cornerRadius(15)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(
            accountBalance: 567855
        )
    }
}
