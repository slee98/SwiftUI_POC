//
//  ProductRowView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct ProductRowView: View {
    
    @EnvironmentObject var cartmanager: ProductManager    
    var product: Product
    
    
    var body: some View {
        HStack() {
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .frame(width: 70)
                .padding(.leading, 20)
            
            
            VStack (alignment: .leading) {
                Text(product.name)
                    .bold()
                
                Text("$\(product.price).00")
                    .font(.body)
                
                
                Text("Quantity: \(cartmanager.arrangedProducts[product] ?? 0)")
                    .foregroundColor(.black)
                    .font(.caption)
                
            }  .frame(width: 240)
            
            Button ( action: {
                
                cartmanager.removeFromCart(product)
                
                
            }){
                Image(systemName: "trash")
                    .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
            }
        }
        .padding(.trailing, 30)
    }
    
    
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product:products[0])
            .environmentObject(ProductManager())
    }
}
