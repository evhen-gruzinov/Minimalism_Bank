//
//  BalanceBlockView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct BalanceBlockView: View {
    var accountBalance: Int?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Balance")
                Text(accountBalance != nil ? Formating().intToMoneyFormat(from: accountBalance!) : "Loading...")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            
            Button("Transactions") {

            }
            .foregroundColor(colorScheme == .dark ? Color.lightDark : Color.white)
            .font(Font.headline.weight(.bold))
            .padding(10)
            .background(colorScheme == .light ? Color.lightDark : Color.white)
            .cornerRadius(15)
        }
        .padding()
        .background(colorScheme == .dark ? Color.lightDark : Color.white)
        .cornerRadius(15)
    }
}

struct BalanceBlockView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BalanceBlockView(
                accountBalance: 567855
            ).environment(\.colorScheme, .light).previewLayout(.sizeThatFits)
            BalanceBlockView(
                accountBalance: 567855
            ).environment(\.colorScheme, .dark).previewLayout(.sizeThatFits)
        }
    }
}
