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
    var userSelection: UserSelectionModel
    
    var body: some View {
        HStack(spacing: 5) {
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
                .frame(width: 90)
            
            VStack (alignment: .leading, spacing: 3) {
                HStack{
                    Text(product.name)
                        .font(.system(size: 14))
                    Spacer()
                    Text("$\(product.price * (cartmanager.arrangedProducts[userSelection] ?? 0))")
                        .font(.system(size: 14))
                    
                }
                
                Text("$\(product.price).00")
                    .font(.system(size: 14))
                    .bold()
                
                HStack {
                    Text("Color: \(userSelection.productColor)")
                        .foregroundColor(.black)
                        .font(.caption)
                    Spacer()
                    Button ( action: {
                        
                        cartmanager.removeFromCart(product)
                        
                    }){
                        Image(systemName: "trash")
                            .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                    }
                }
                
                Text("Size: \(userSelection.productSize)")
                    .foregroundColor(.black)
                    .font(.caption)
                
                Text("QTY: \(cartmanager.arrangedProducts[userSelection] ?? 0)")
                    .foregroundColor(.black)
                    .font(.caption)
            }
            .padding(.bottom, 20)
            .frame(width: 250)
        }
    }
}

struct ProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product:products[0], userSelection: UserSelectionModel(productInfo: products[0], productSize: "XS", productColor: "Brown"))
            .environmentObject(ProductManager())
    }
}
