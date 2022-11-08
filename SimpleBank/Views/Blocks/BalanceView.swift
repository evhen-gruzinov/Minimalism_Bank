//
//  BalanceView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct BalanceView: View {
    var accountBalance: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Balance")
                // TODO: placeholder while loading data from server
                Text(Formating().moneyFormating(moneyValue: accountBalance))
                    .font(.title)
                    .bold()
            }
            Spacer()
            
            Button("Transactions") {

            }
            .foregroundColor(Color.white)
            .bold()
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
            accountBalance: 123456
        )
    }
}
