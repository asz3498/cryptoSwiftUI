//
//  ContentView.swift
//  CryptoSwiftUI
//
//  Created by Samet Zehiroğlu on 29.11.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    @State private var searchText = ""
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(cryptoListViewModel.cryptoList.filter { crypto in
                    searchText.isEmpty || crypto.currency.localizedCaseInsensitiveContains(searchText)
                }, id: \.id) { crypto in
                    
                    VStack{
                        Text(crypto.currency)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 100, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        Text(crypto.price)
                            .font(.subheadline)
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                    }
                    
                }.navigationTitle("Kripto Para Listesi")
                
                    .searchable(text: $searchText)
                
            }.onAppear{
                cryptoListViewModel.downloadCryptos(url: URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            }
        }
    }
}
#Preview {
    MainView()
}
