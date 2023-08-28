//
//  WishListView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/14/23.
//

import SwiftUI

struct WishListView: View {
    
    @EnvironmentObject var cartManager: ProductManager
    @Environment(\.presentationMode) var presentationMode

    
    
    var columns = [
        GridItem(.fixed(5), spacing: 185),
        GridItem(.fixed(5), spacing: 185)
    ]
    
    
    var body: some View {
        
        VStack {
            VStack(spacing:1) {
                Text("AU")
                    .bold()
                    .font(.system(size:16))
                    
                        
                Text("WishList")
                    .bold()
                    .font(.system(size:20))

            }
            
            Divider()
            
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 50) {
                    
                    if cartManager.savedProducts.count > 0 {
                        let uniquesavedProducts = Array(Set(cartManager.savedProducts))
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(uniquesavedProducts, id: \.id) {
                                savedProduct in
                                
                                SaveProductRowView(product: savedProduct, userSelection: UserSelectionModel(productInfo: products[0], productSize: "XS", productColor: "White"))
                                    .padding(.top,20)
                                
                            }
                            
                        } } else {
                            VStack {
                                Text("Your WishList is currently empty.")
                                    .bold()
                                    .padding(.top,30)
                                
                                Button(action: {
                                    
                                    presentationMode.wrappedValue.dismiss() //dismiss the screen
                                    
                                    
                                }, label: {
                                    Text("Shop Now")
                                        .foregroundColor(.black)
                                    
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(.black, lineWidth: 1)
                                                .frame(width: 150, height: 30)
                                        )
                                        .padding()
                                })
                                
                            }
                            .frame(width: 300)

                        }
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
