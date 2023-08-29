//
//  SplashView.swift
//  ShoppingApp
//
//  Created by Soyeon Lee on 8/28/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State var isActive: Bool = false
    @State var text: String = ""
    let finalText: String = "Welcome To"
        
    
    var body: some View {
        if isActive {
            MainView()
                .environmentObject(ProductManager())
        } else {
            
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.white]), center: .center, startRadius: 2, endRadius: 300)
                        .ignoresSafeArea()
                    
                VStack {
                    Text(text)
                        .font(.caption)
                        .foregroundColor(.white)
                        .onAppear{
                            typeWriter()
                        }
                    
                    Text("AU")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.isActive = true
                }
            }
        }
           
        
    }
       


func typeWriter(at position: Int = 0) {
      if position == 0 {
          text = ""
      }
      if position < finalText.count {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
              text.append(finalText[position])
              typeWriter(at: position + 1)
          }
      }
  }
}


struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
