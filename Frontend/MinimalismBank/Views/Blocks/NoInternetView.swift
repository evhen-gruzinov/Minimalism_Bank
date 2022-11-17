//
//  Created by Evhen Gruzinov on 17.11.2022.
//

import SwiftUI

struct NoInternetView: View {
    var disappear: () -> Void
    @State var isConnected = NetworkManager().isConnectedToInternet()
    
    var body: some View {
        ZStack {
            if !isConnected {
                HStack {
                    Spacer()
                    VStack {
                        Label("noInternet", systemImage: "wifi.exclamationmark").font(.title3)
                        Text("noInternetDescription").multilineTextAlignment(.center)
                    }
                    Spacer()
                }
                .padding()
                .onDisappear() {
                    self.disappear()
                }
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {(_) in
                isConnected = NetworkManager().isConnectedToInternet()
            }
        }
    }
}

struct NoInternetView_Previews: PreviewProvider {
    static var previews: some View {
        NoInternetView(disappear: {}).previewLayout(.sizeThatFits)
    }
}
