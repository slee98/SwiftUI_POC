//
//  CartManager.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import Foundation

class ProductManager: ObservableObject {
    
    @Published private(set) var cartProducts: [UserSelectionModel] = [] //Product, ProductSize, ProductColor
    @Published private(set) var totalPrice: Int =  0
    @Published private(set) var savedProducts: [Product] = []
    @Published var searchItem: String = ""
   
    init () {
            
//        loadCart()
//        loadSaveProducts()
    }
    
    var filteredProducts : [Product] {
        return products.filter { product in
            product.name.lowercased().hasPrefix(searchItem.lowercased())
        }
    }
    
    
    //Computed Property
    var arrangedProducts: [UserSelectionModel: Int] {
        var map = [UserSelectionModel: Int]()
        for i in 0 ..< cartProducts.count {
            
            if (map[cartProducts[i]] == nil) {
                map[cartProducts[i]] = 1
            } else {
                map[cartProducts[i]]! += 1
            }
        }
        return map
    }
    
    
    func addToCart(_ addedProduct:Product, _ selectedSize: String, _ selectedColor: String ) {
        
        let userSelection = UserSelectionModel(productInfo: addedProduct, productSize: selectedSize, productColor: selectedColor)
        cartProducts.append(userSelection)
        totalPrice += addedProduct.price
       // saveProductInCarts()
        
    }
    
//    func saveProductInCarts() {
//
//        do {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//            let jsonData = try encoder.encode(cartProducts)
//
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
//                    try jsonData.write(to: fileURL)
//                    }
//                }
////            let jsonData = try JSONSerialization.data(withJSONObject: products, options: .prettyPrinted)
////            if let jsonString = String(data: jsonData, encoding: .utf8) {
////                print(jsonString)
////            }
//            } catch {
//                print("Error serializing JSON In Cart Products")
//                }
//            }
    
//    func loadCart() {
//        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
//            do {
//                let jsonData = try Data(contentsOf: fileURL)
//                let decoder = JSONDecoder()
//                cartProducts = try decoder.decode([Product].self, from: jsonData)
//                totalPrice = cartProducts.reduce(0 , {$0 + $1.price})
//            } catch {
//                print("error loading cart")
//            }
//        }
//    }
//
    func removeFromCart(_ removedProduct:Product) {
        //products =  products.filter { $0.id != removedProduct.id }
        for i in 0 ..< cartProducts.count {
            if (cartProducts[i].productInfo.id == removedProduct.id) {
                cartProducts.remove(at: i)
                totalPrice -= removedProduct.price
                break
                
            }
        }
    }
    
    func addToSave(_ savedProduct:Product) {
        savedProducts.append(savedProduct)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(savedProducts)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
            }
//            let jsonData = try JSONSerialization.data(withJSONObject: products, options: .prettyPrinted)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//            }
        } catch {
            print("Error serializing JSON In Saved Products")
        }
    }
    
    
//    func loadSaveProducts() {
//        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
//            do {
//                let jsonData = try Data(contentsOf: fileURL)
//                let decoder = JSONDecoder()
//                cartProducts = try decoder.decode([Product].self, from: jsonData)
//                totalPrice = cartProducts.reduce(0 , {$0 + $1.price})
//            } catch {
//                print("error loading cart")
//            }
//        }
//    }
    
    func removeFromSave(_ unsavedProduct:Product) {
        //products =  products.filter { $0.id != removedProduct.id }
        
        for i in 0 ..< savedProducts.count {
            
            if (savedProducts[i].id == unsavedProduct.id) {
                savedProducts.remove(at: i)
                break
                
            }
        }
        
        for i in 0 ..< cartProducts.count {
            if (cartProducts[i].productInfo.id == unsavedProduct.id) {
                break
                
            }
        }
    }
}


