//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct MainView: View {
    
    let productManager = ProductManager()
    
    var body: some View {
        
        TabView {
            
            ShopView()
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
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white
        }
        .environmentObject(productManager)
        .accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ProductManager())
    }
}

