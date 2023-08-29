//
//  ShopView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/13/23.
//

import SwiftUI

struct ShopView: View {
    
    private let categories = ["All", "Tops", "Jackets", "Pants", "Skirts", "Shoes", "Sale"]
    @EnvironmentObject var cartmanager : ProductManager
    @State private var isCartViewPresented = false
    @State var selectedCategory : String = "All"
    @State var filteredProducts = products
    
    
    var columns = [
        GridItem(.fixed(5), spacing: 185),
        GridItem(.fixed(5), spacing: 185)
    ]
    
    
    
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 30)
                
                Text("AU")
                    .bold()
                    .font(.system(size:25))
                    .padding(.top, 10)
                
                
                Button(action: {
                    isCartViewPresented = true
                }) {
                    CartButtonView(numberOfProducts: cartmanager.cartProducts.count)
                        .foregroundColor(.black)
                        .padding(.leading, 300)
                }
                
                .sheet(isPresented: $isCartViewPresented, content: {
                    CartView()
                })
            }
            
            
            HStack(){
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("CustomColor"))
                    .padding()
                
                TextField("Search", text:  $cartmanager
                    .searchItem)
                .foregroundColor(Color.black)
                .font(.system(size: 15.0))
                
                
            }
            .frame(width: 350, height: 30)
            .font(.headline)
            .background(
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color("CustomColor"), radius: 10, x: 0, y: 0)
                
            )
            .padding(.horizontal)
            .padding(.top, 10)
            
            
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack(spacing:10) {
                    
                    ForEach(0 ..< categories.count) { i in
                        
                        
                        Button(action: {
                            
                            selectedCategory = categories[i]
                            
                            if selectedCategory == "All" {
                                filteredProducts = products
                                
                            } else {filteredProducts = products
                                    .filter({ product in
                                        product.category == selectedCategory
                                    })
                            }}, label: {
                                
                                
                                Text(categories[i])
                                    .font(.system(size: 12))
                                    .bold()
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                    .foregroundColor(.black)
                                    .background(
                                        selectedCategory ==  categories[i] ? Color.gray.opacity(0.3) : Color.gray.opacity(0.1) ,
                                        in: RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                                    )
                                
                                
                            })
                        
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
            }
            
            
            ScrollView {
                
                LazyVGrid(columns: columns, spacing: 30) {
                    
                    
                    ForEach(filteredProducts, id: \.self)
                    { product in
                        
                        ProductCardView(product: product)
                  
                        
                        
                    }
                }
            }
            
            
        }
    }
}



struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(ProductManager())
        
        
    }
}
