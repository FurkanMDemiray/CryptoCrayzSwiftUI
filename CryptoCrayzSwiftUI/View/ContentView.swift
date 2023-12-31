//
//  ContentView.swift
//  CryptoCrayzSwiftUI
//
//  Created by Melik Demiray on 30.12.2023.
//

import SwiftUI

struct ContentView: View {

    var cryptoList = [Crypto]()


    var body: some View {
        List(cryptoList) { crypto in
            Text(crypto.currency)
        }
    }
}

#Preview {
    ContentView()
}
