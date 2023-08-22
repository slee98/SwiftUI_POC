//
//  WishListView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/14/23.
//

import SwiftUI

struct WishListView: View {
    
    @EnvironmentObject var cartManager: ProductManager
    
    
    var columns = [
        GridItem(.fixed(5), spacing: 185),
        GridItem(.fixed(5), spacing: 185)
    ]
    
    
    var body: some View {
        
        VStack {
            HStack {
                
                Text("Wish List")
                    .bold()
                    .font(.system(size: 20))
                
                
            } .padding(.top, 20)
            
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 30) {
                    
                    if cartManager.savedProducts.count > 0 {
                        let uniquesavedProducts = Array(Set(cartManager.savedProducts))
                        
                        LazyVGrid(columns: columns) {
                            ForEach(uniquesavedProducts, id: \.id) {
                                product in
                                
                                SaveProductRowView(product: product)
                                
                            }
                        } }
                }
                .padding(.leading, 200)
                
            }
        }
    }}

struct WishListView_Previews: PreviewProvider {
    static var previews: some View {
        WishListView()
            .environmentObject(ProductManager())
        
    }
}
