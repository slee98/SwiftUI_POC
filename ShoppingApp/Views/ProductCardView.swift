//
//  ProductCardView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct ProductCardView: View {
    
    @EnvironmentObject var cartmanager: ProductManager
    
    @State var descriptionView : Bool = false
    @State var selectedColor: String = "Brown"
   

    var product : Product
    
    var body: some View {
        
        
        VStack {
            ZStack(alignment: .topTrailing) {
                
                Button(action: {
                    descriptionView = true
                    selectedColor = product.colorName

                }) {
                    
                    Image(product.imageName)
                        .resizable()
                        .cornerRadius(3)
                        .frame(width: 180,height: 270)
                        

                }
                .sheet(isPresented: $descriptionView, content: {

                    ProductDetailView(selectedColor: $selectedColor, product: product)
                        .environmentObject(cartmanager)
                })
                
                Button(action: {
                    
                    if cartmanager.savedProducts.contains(product) {
                        cartmanager.removeFromSave(product)
                    } else {
                        cartmanager.addToSave(product)
                    }
                    
                    // Update the binding value
                }, label: {
                    
                    Image(systemName: cartmanager.savedProducts.contains(product) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 24, height: 22)
                        .foregroundColor(Color("CustomColor"))
                        .padding()


                })
            }
            
            VStack {
                
                Text(product.name)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top,5)
                
                
                Text("$\(product.price).00")
                    .font(.caption)
            }
            
            .frame(width: 180, height: 40)
            
            
            
        }
    }
    
    
}


struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: products[1])
            .environmentObject(ProductManager())
        
        
    }
}
