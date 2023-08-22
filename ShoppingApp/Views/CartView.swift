//
//  CartView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: ProductManager
    @Environment(\.presentationMode) var presentationMode
    var columns = [
        GridItem(.fixed(10), spacing: 100),
    ]
    
    
    var body: some View {
        VStack {
            HStack {
                Text("AU")
                    .bold()
                    .font(.system(size:20))
                    .padding(.top, 50)
                
                
            }
            
            ScrollView{
                
                if cartManager.products.count > 0 {
                    let uniqueProducts = Array(Set(cartManager.products))
                    
                    LazyVGrid(columns: columns) {
                        ForEach(uniqueProducts, id: \.id) {
                            product in
                            
                            ProductRowView(product: product)
                        }
                    }
                    
                    
                    HStack {
                        Text("Your cart total is")
                        Spacer()
                        Text("$\(cartManager.totalPrice).00")
                            .bold()
                    }.padding()
                } else {
                    Text("Your Shopping Bag is currently empty")
                        .bold()
                    
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
            }
            .navigationTitle(Text("My Cart"))
            .padding(.top)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ProductManager())
    }
}
