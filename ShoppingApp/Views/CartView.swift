//
//  CartView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartmanager : ProductManager
    @Environment(\.presentationMode) var presentationMode
    var columns = [
        GridItem(.fixed(10), spacing: 100),
    ]
    
    var body: some View {
        VStack {
            VStack(spacing:1) {
                Text("AU")
                    .bold()
                    .font(.system(size:16))
                    .padding(.top, 50)
                
                Text("Shopping Bag")
                    .bold()
                    .font(.system(size:20))
            }
            
            Divider()
            ScrollView{
                
                if cartmanager.cartProducts.count > 0 {
                    
                    let uniqueProducts = Array(Set(cartmanager.cartProducts))
                    
                    LazyVGrid(columns: columns) {
                        ForEach(uniqueProducts, id: \.self) { userSelection in
                            Divider()
                            
                            ProductRowView(product: userSelection.productInfo, userSelection: UserSelectionModel(productInfo: userSelection.productInfo, productSize: userSelection.productSize, productColor: userSelection.productColor))
                        }
                    }
                    
                    VStack(spacing: 1){
                        HStack {
                            Text("Subtotal")
                            Spacer()
                            Text("$\(cartmanager.totalPrice).00")
                                .bold()
                        }
                        HStack {
                            Text("Shipping")
                            Spacer()
                            Text("TBD")
                                .bold()
                        }
                        HStack {
                            Text("Estimated Tax")
                            Spacer()
                            Text("$0.00")
                                .bold()
                        }
                    }
                    .padding(.horizontal, 20)
                    .font(.system(size: 14))
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
