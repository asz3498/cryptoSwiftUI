//
//  CryptoViewModel.swift
//  CryptoSwiftUI
//
//  Created by Samet Zehiroğlu on 29.11.2023.
//

import Foundation
import Combine

@MainActor
class CryptoListViewModel : ObservableObject {
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = Webservice()
    
    func downloadCryptos(url : URL) {
        
        webservice.downloadCurrencies(url: url) { result in
            switch result {
                case .failure(let error):
                print(error)
                
            case .success(let cryptos):
                if let cryptos = cryptos {
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CryptoViewModel.init)
                    }
                    
                    
                }
            }
        }
    }
}

struct CryptoViewModel {
    
    let crypto : CryptoCurrency
    
    var id : UUID?{
        crypto.id
    }
    
    var currency : String{
        crypto.currency
    }
    
    var price : String{
        crypto.price
    }
}
