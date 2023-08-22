//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/9/23.
//

import SwiftUI

@main
struct ShoppingAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ProductManager())
                
        }
    }
}
