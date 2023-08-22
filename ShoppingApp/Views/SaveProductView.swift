//
//  SaveProductView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/14/23.
//

import SwiftUI

struct SaveProductRowView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
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
            

            }
            }
        .padding(.trailing, 30)
        }
      
       
    
}

struct SaveProductRowView_Previews: PreviewProvider {
    static var previews: some View {
        SaveProductView(product: productList[3])
            .environmentObject(CartManager())
    }
}
