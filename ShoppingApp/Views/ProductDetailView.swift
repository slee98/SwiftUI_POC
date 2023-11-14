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
    @State var selectedSize: String = "XS"
    @State var selectedColor: String = ""
    @State var rating: Int = 4
    
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
    ]
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.top)
                
                VStack {
                    ZStack {
                        Image(product.imageName)
                            .resizable()
                            .frame(width: 400, height: 550)
                        
                        Rectangle()
                            .frame(width: 50, height: 50, alignment: .leading)
                            .foregroundColor(selectedColor.isEmpty ?
                                             colorMap[product.avaliableColor.first?.lowercased() ?? "black"] : colorMap[selectedColor.lowercased()])
                        
                            .padding(.top, 450)
                            .padding(.trailing, 300)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.system(size: 16))
                            .padding(.top, 10)
                        
                        
                        Text("$\(product.price).00")
                            .font(.body)
                            .bold()
                        
                        Spacer()
                        
                        HStack {
                            Text("Color: \(selectedColor.isEmpty ? product.avaliableColor.first! : selectedColor)")
                                .font(.system(size: 14))
                            
                            Spacer()
                            Text("Size")
                                .font(.system(size: 14))
                                .padding(.trailing,30)
                        }
                        
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
                                                        .strokeBorder( selectedColor == colorName ? Color.black : Color.clear, lineWidth: 0.8)
                                                        .frame(width: 40, height: 40)
                                                )
                                            
                                        } else if selectedColor.isEmpty && colorName == product.avaliableColor.first {
                                            Circle()
                                                .fill(color)
                                                .frame(width: 30, height: 30)
                                                .overlay(
                                                    Circle()
                                                        .strokeBorder(selectedColor.isEmpty ? Color.black : Color.clear, lineWidth: 0.8)
                                                        .frame(width: 40, height: 40)
                                                )
                                        }
                                        
                                        else {
                                            Circle()
                                                .fill(color)
                                                .frame(width: 30, height: 30)
                                                .overlay(
                                                    Circle()
                                                        .strokeBorder(  selectedColor  == colorName ? Color.black : Color.clear, lineWidth: 0.8)
                                                        .frame(width: 40, height: 40)
                                                    
                                                )
                                        }
                                    }
                                })
                            }
                            
                            Spacer()
                            Picker (
                                selection: $selectedSize ,
                                label: Text("Select A Size"),
                                content:  {
                                    
                                    ForEach(sizeOptions, id: \.self) { option in
                                        Text("\(option)")
                                    }
                                })
                            .pickerStyle(.menu)
                            .padding(.trailing,10)
                        }
                        HStack {
                            Text("Rating: ")
                                .font(.system(size: 14))
                            
                            ForEach(1..<6) {
                                index in
                                Image(systemName: "star.fill")
                                    .font(.body)
                                    .foregroundColor(rating >= index ? Color.pink.opacity(0.5): Color.gray.opacity(0.5))
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }.padding(.top, 10)
                        
                        VStack(alignment:.leading ,spacing:1) {
                            Text("Description:")
                                .font(.system(size: 14))
                            
                            Text("\(product.description)")
                                .frame(width: 300, height: 50, alignment: .leading)
                                .font(.system(size: 12))
                        } .padding(.top, 5)
                        
                        Button(action: {
                            
                            cartmanager.addToCart(product, selectedSize, selectedColor)
                            showingAlertDetail = true
                            
                        }, label: {
                            Text("ADD TO BAG")
                                .foregroundColor(.black)
                                .font(.system(size: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                                        .frame(width: 200, height: 40)
                                )
                                .padding(.top, 30)
                                .padding(.leading, 130)
                        })}
                    .alert("Item Added To Cart", isPresented: $showingAlertDetail) {
                        Button("OK", role: .cancel) { }
                    }
                    .padding(.leading, 30)
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: products[1])
    }
}

