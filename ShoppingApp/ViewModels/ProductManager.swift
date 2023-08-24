//
//  CartManager.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import Foundation

class ProductManager: ObservableObject {
    
    @Published private(set) var products: [Product] = []
    @Published private(set) var totalPrice: Int =  0
    @Published private(set) var savedProducts: [Product] = []
    @Published var searchItem: String = ""

    init () {
            
        loadCart()
        loadSaveProducts()
    }
    

    
    var filteredProducts: [Product] {
        if searchItem.isEmpty {
            return products
        } else {
            return products.filter { $0.name.localizedCaseInsensitiveContains(searchItem) }
        }
    }
    
    
    //Computed Property
    var arrangedProducts: [Product: Int] {
        var map = [Product: Int]()
        for i in 0 ..< products.count {
            
            if (map[products[i]] == nil) {
                map[products[i]] = 1
            } else {
                map[products[i]]! += 1
            }
        }
        return map
    }
    
    
    func addToCart(_ addedProduct:Product) {
        products.append(addedProduct)
        totalPrice += addedProduct.price
        saveProductInCarts()
        
    }
    
    func saveProductInCarts() {
    
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(products)
        
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
                    try jsonData.write(to: fileURL)
                    }
                }
//            let jsonData = try JSONSerialization.data(withJSONObject: products, options: .prettyPrinted)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//            }
            } catch {
                print("Error serializing JSON In Cart Products")
                }
            }
    
    func loadCart() {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                products = try decoder.decode([Product].self, from: jsonData)
                totalPrice = products.reduce(0 , {$0 + $1.price})
            } catch {
                print("error loading cart")
            }
        }
    }
    
    func removeFromCart(_ removedProduct:Product) {
        //products =  products.filter { $0.id != removedProduct.id }
        for i in 0 ..< products.count {
            if (products[i].id == removedProduct.id) {
                products.remove(at: i)
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
                print(jsonString)
            }
//            let jsonData = try JSONSerialization.data(withJSONObject: products, options: .prettyPrinted)
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                print(jsonString)
//            }
        } catch {
            print("Error serializing JSON In Saved Products")
        }
    }
    
    
    func loadSaveProducts() {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("products.json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                products = try decoder.decode([Product].self, from: jsonData)
                totalPrice = products.reduce(0 , {$0 + $1.price})
            } catch {
                print("error loading cart")
            }
        }
    }
    
    func removeFromSave(_ unsavedProduct:Product) {
        //products =  products.filter { $0.id != removedProduct.id }
        
        for i in 0 ..< savedProducts.count {
            
            if (savedProducts[i].id == unsavedProduct.id) {
                savedProducts.remove(at: i)
                break
                
            }
        }
        
        for i in 0 ..< products.count {
            if (products[i].id == unsavedProduct.id) {
                break
                
            }
        }
    }
}


