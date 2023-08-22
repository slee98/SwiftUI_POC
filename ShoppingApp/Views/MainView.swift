//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        TabView {
            
            ShopView(product: products[1])
                .tabItem {
                    Image(systemName: "tshirt")
                    Text("Shop")
                }
            
            WishListView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("WishList")
                }
            
        }
        .accentColor(.black)
        
        
    }}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ProductManager())
        
    }
}

