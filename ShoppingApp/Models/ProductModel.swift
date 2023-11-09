//
//  ProductModel.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import Foundation
import SwiftUI

struct Product: Identifiable, Hashable, Codable {
    
    var id = UUID().uuidString
    var category: String
    var name: String
    var description: String
    var imageName: String
    var price: Int
    var colorName: String
    var avaliableColor: [String]
    
}

extension Product {
    
    var color : Color {
        
        let colorCode = colorName.lowercased()
        
        switch colorCode {
            
        case "pink":
            return Color.pink
        case "red":
            return Color.red
        case "brown":
            return Color.brown
        case "blue":
            return Color.blue
        case "white":
            return Color.white
        case "skyblue":
            return Color.blue.opacity(0.5)
        default:
            print("Unsupported Colorcode: \(colorCode)")
            return Color.black
        }
    }
}
