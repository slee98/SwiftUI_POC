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
    @Binding var selectedColor: String

    
    
    // var color: Color = .red
    var product: Product
    
    let colorMap: [String: Color] = [
        "brown": .brown,
        "yellow": .yellow,
        "purple": .purple,
        "black": .black,
        "pink": .pink,
        "white": .white,
        "red": .red,
        "green": .green,
        "skyblue": Color.blue.opacity(0.5),
        "orange": .orange


        // Add more color mappings as needed
    ]
    
    
    var body: some View {
        ScrollView {
            
            ZStack {
                Color.white
                
                
                VStack {
                    
                    ZStack {
                        Image(product.imageName)
                            .resizable()
                            .frame(width: 300, height: 400)
                        Rectangle()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(selectedColor != nil ? colorMap[selectedColor.lowercased()] : .clear)
                            .padding(.top, 350)
                            .padding(.trailing, 250)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.system(size: 16))
                            .bold()
                        
                        Text("$\(product.price).00")
                            .font(.caption)
                        
                        Spacer()
                        
                        
                        Text("Color: \(selectedColor)")
                            .font(.system(size: 14))
                        
                        HStack(spacing: 10) {
                        ForEach(product.avaliableColor, id: \.self) { colorName in
                            Button(action: {
                                
                                selectedColor = colorName
                                
                            }, label: {
                                
                                if let color = colorMap[colorName.lowercased()] {
                                    if color == .white {
                                        Circle()
                                            .strokeBorder(.black, lineWidth: 0.8)
                                            .background(Circle().fill(color))
                                            .frame(width: 30, height: 30)
                                            .overlay(
                                                Circle()
                                            .strokeBorder(selectedColor == colorName ? Color.black : Color.clear, lineWidth: 0.8)
                                            .frame(width: 40, height: 40)
                                                )

                                    } else {
                                        Circle()
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .overlay(
                                                Circle()
                                                    .strokeBorder(selectedColor == colorName ? Color.black : Color.clear, lineWidth: 0.8)
                                                    .frame(width: 40, height: 40)
                                                    
                                            )
                                            

                                            

                                        }
                                    }
                                
                            })
                           
                            }
                        }
                        
                        HStack {
                            Text("Size:")
                                .font(.system(size: 14))
                            Spacer()
                            Picker (
                                selection: $sizeSelected,
                                label: Text("Select A Size")
                                ,
                                
                                content:  {
                                    
                                    ForEach(sizeOptions, id: \.self) { option in
                                        Text("\(option)")
                                        
                                    }
                                })
                            .pickerStyle(MenuPickerStyle())
                            Spacer() // Pushes the picker to the left

                        }
                        
                        
                        Text("Description:")
                            .font(.system(size: 14))
                        
                        Text("\(product.description)")
                            .frame(width: 300, height: 50, alignment: .leading)
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
        ProductDetailView(selectedColor: .constant("Brown"), product: products[0])
    }
}
