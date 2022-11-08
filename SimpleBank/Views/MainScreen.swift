//
//  ContentView.swift
//  SimpleBank
//
//  Created by Evhen Gruzinov on 08.11.2022.
//

import SwiftUI

struct MainScreen: View {
    var accountBalance: Int
//    @State var accountBalance: Int
    
    var body: some View {
        VStack {
            BalanceView(accountBalance: accountBalance)
            Spacer()
        }
        .padding()
        .background(Color(red: 0.949, green: 0.949, blue: 0.949))
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(
            accountBalance: 5555//.12.rounded(toPlaces: 2)
        )
    }
}
