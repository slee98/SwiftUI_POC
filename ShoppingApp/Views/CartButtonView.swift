//
//  CartButtonView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

struct CartButtonView: View {
    
    var numberOfProducts: Int //users has in the cart.
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .resizable()
                .frame(width: 25, height: 25)
                .padding(.trailing, 10)
                .padding(.top, 5)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 20, height:20)
                    .background(.black)
                    .cornerRadius(50)
            }
            
        }
    }
}
struct CartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CartButtonView(numberOfProducts: 1)
        
    }
}
