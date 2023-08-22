//
//  CustomNavBarView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/11/23.
//

import SwiftUI

struct CustomNavBarView: View {
    
    @EnvironmentObject var cartmanager: CartManager

    var body: some View {
        NavigationView {
     
       
       
        }
       

    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBarView()
            .environmentObject(CartManager())
          
    }
}
