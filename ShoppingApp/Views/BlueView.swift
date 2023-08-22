//
//  BlueView.swift
//  Practice
//
//  Created by Soyeon Lee on 8/16/23.
//

import SwiftUI

struct BlueView: View {
    @ObservedObject var savedProduct = SavedProductViewModel() // Use ObservedObject instead of EnvironmentObject
    
    var body: some View {
        VStack {
            Button {
                savedProduct.savedButtonClicked.toggle()

            } label: {
                Image(systemName: savedProduct.savedButtonClicked ? "heart.fill" : "heart")
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .tint(savedProduct.savedButtonClicked ? .blue : .red)
            
        }
        .padding(50)
        .background {
            Color.blue
        }
    }
}


struct BlueView_Previews: PreviewProvider {
    static var previews: some View {
        BlueView()
            .environmentObject(SavedProductViewModel())
    }
}

