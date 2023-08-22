//
//  ProductDetailView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/14/23.
//

import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var cartmanager: ProductManager
    let sizeOptions = ["XS", "S", "M", "L", "XL"]
    @State private var sizeSelected = "XS"
    @State private var showingAlertDetail = false
    
    // var color: Color = .red
    var product: Product
    
    var body: some View {
        ScrollView {
            
            ZStack {
                Color.white
                
                
                VStack {
                    
                    Image(product.imageName)
                        .resizable()
                        .frame(width: 300, height: 400)
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.system(size: 16))
                            .bold()
                        
                        Text("$\(product.price).00")
                            .font(.caption)
                        
                        Spacer()
                        
                        
                        Text("Color: \(product.colorName)")
                            .font(.system(size: 12))
                        
                        Circle()
                            .fill(product.color)
                            .frame(width: 30, height: 30)
                        
                        
                        HStack {
                            Text("Size:")
                            Spacer()
                            Picker (
                                selection: $sizeSelected,
                                label: Text("Select A Size"),
                                
                                
                                content:  {
                                    
                                    ForEach(sizeOptions, id: \.self) { option in
                                        Text("\(option)")
                                        
                                    }
                                })
                            
                            .pickerStyle(MenuPickerStyle())
                            
                            
                            .foregroundColor(Color.black.opacity(0.6))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10, height: 10)
                                .padding(.trailing, 50)
                        }
                        .font(Font.custom("Avenir Next", size: 16).weight(.medium))
                        .background(Color.white)
                        
                        Text("Description:")
                            .font(.system(size: 15))
                        
                        Text("\(product.description)")
                            .frame(width: 300, height: 40)
                            .font(.system(size: 12))

                        Button(action: {
                            
                            cartmanager.addToCart(product)
                            // Update the binding value
                            showingAlertDetail = true
                            
                            
                            
                        }, label: {
                            //  If product is in cartMaager.products, use "minus". "plus" otherwise
                            Text("ADD TO BAG")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                                        .frame(width: 170, height: 30)
                                    
                                )
                                .padding(.top, 30)
                                .padding(.leading, 100)
                            
                            
                        })
                        
                        .alert("Item Added To Cart", isPresented: $showingAlertDetail) {
                            Button("OK", role: .cancel) { }
                        }
                        
                    }
                    .padding(.leading, 50)
                    
                }
            }
            
        }
    }
    
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: products[0])
    }
}
