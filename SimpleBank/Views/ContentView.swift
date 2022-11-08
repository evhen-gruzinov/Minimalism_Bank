//
//  ContentView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct ContentView: View {
    var moneyBalance: Double
    
    var body: some View {
        VStack {
            BalanceView(accountBalance: moneyFormated(moneyValue: moneyBalance))
            Spacer()
        }
        .padding()
        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            moneyBalance: 5555.12.rounded(toPlaces: 2)
        )
    }
}



// TODO: Move functions at another files

func moneyFormated(moneyValue: Double) -> String {
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale.current
    
    let formatedString = currencyFormatter.string(from: NSNumber(value: moneyValue))!
    return formatedString
}
