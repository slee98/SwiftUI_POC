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


