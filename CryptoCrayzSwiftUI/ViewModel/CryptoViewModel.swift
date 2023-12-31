//
//  CryptoViewModel.swift
//  CryptoCrayzSwiftUI
//
//  Created by Melik Demiray on 31.12.2023.
//

import Foundation



class CryptoListViewModel: ObservableObject {

    let webservice = WebService()

    @Published var cryptos = [CryptoViewModel]()

    func downloadCryptos(url: URL) {

        webservice.downloadCurreciens(url: url) { result in

            switch result {

            case .success(let cryptos):
                DispatchQueue.main.async {
                    self.cryptos = cryptos.map(CryptoViewModel.init)
                }
            case .failure(let error):
                print(error.localizedDescription)


            }
        }
    }
}



struct CryptoViewModel {

    var crypto: Crypto

    var id: UUID {
        crypto.id
    }
    var price: String {
        crypto.price
    }
    var currency: String {
        crypto.currency
    }

}



