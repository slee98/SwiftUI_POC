//
//  BlackView.swift
//  Practice
//
//  Created by Soyeon Lee on 8/16/23.
//

import SwiftUI

struct BlackView: View {
    @ObservedObject var savedProduct = SavedProductViewModel() // Use ObservedObject instead of EnvironmentObject
    
    var body: some View {
        VStack(alignment: .center) {
           
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
            Color.black
        }
    }
}

struct BlackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackView()

    }
}

