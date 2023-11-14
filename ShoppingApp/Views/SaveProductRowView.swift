//
//  SaveProductRowView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/14/23.
//

import SwiftUI


struct SaveProductRowView: View {
    
    @EnvironmentObject var cartmanager: ProductManager
    @State private var showingAlert = false
    
    @State var product : Product
    @State var userSelection : UserSelectionModel
    
    var body: some View {
     VStack {
         ZStack {
             Image(product.imageName)
                 .resizable()
                 .cornerRadius(3)
                 .frame(width: 170,height: 240)
             
             Button(action: {
                 
                 if cartmanager.savedProducts.contains(product) {
                     cartmanager.removeFromSave(product)
                 } else {
                     cartmanager.addToSave(product)
                 }
                 
                 // Update the binding value
             }, label: {
                 //  If product is in cartMaager.products, use "minus". "plus" otherwise
                 Image(systemName: cartmanager.savedProducts.contains(product) ? "heart.fill" : "heart")
                     .resizable()
                     .frame(width: 24, height: 22)
                     .foregroundColor(Color("CustomColor"))
                     .padding(.bottom, 200)
                     .padding(.leading, 130)
             })
         }
            VStack (alignment: .leading) {
                Text(product.name)
                    .bold()
                    .font(.system(size: 14))
                
                Text("$\(product.price).00")
                    .font(.caption)
                
                Button(action: {
                    
                    cartmanager.addToCart(userSelection.productInfo, userSelection.productSize, userSelection.productColor)
                    showingAlert = true
                    
                }, label: {
                    
                    Text("ADD TO BAG")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.leading, 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray.opacity(0.4), lineWidth: 1)
                                .frame(width: 170, height: 30)
                                .padding(.leading, 30)
                        )
                        .padding(.top, 10)
                })
                .alert("Item Added To Cart", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .frame(width: 170)
        }
    }
}

struct SaveProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        SaveProductRowView(product: products[0], userSelection: UserSelectionModel(productInfo: products[0], productSize: "bb", productColor: "Bb"))
            .environmentObject(ProductManager())
    }
}
