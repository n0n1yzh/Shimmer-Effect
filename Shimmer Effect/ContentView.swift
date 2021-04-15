//
//  ContentView.swift
//  Shimmer Effect
//
//  Created by YZH on 2021/3/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    // Toggle For MultiColors
    @State var multiColor = false
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            TextShimmer(text: "Welcome", multiColors: $multiColor)
            
            TextShimmer(text: "Back", multiColors: $multiColor)
            
            TextShimmer(text: "Zhra1n", multiColors: $multiColor)
            
            Toggle(isOn: $multiColor, label: {
                Text("Enable Multi Color")
                    .font(.title)
                    .fontWeight(.bold)
            })
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

// Text Shimmer

struct TextShimmer: View {
     
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        
        ZStack {
            
            Text(text)
                .font(.system(size: 70, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
            HStack(spacing: 0) {
                
                ForEach(0..<text.count, id: \.self) { index in
                    
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            // Masking For Shimmer Effet
            .mask(
                
                Rectangle()
                    .fill(
                        LinearGradient(gradient: .init(colors: [Color.white.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .padding(20)
                // Moving View Continouslt
                    .offset(x: -250)
                    .offset(x: animation ? 500 : 0)
            )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    animation.toggle()
                }
            })
        }
    }
    
    // Random Color
    
    func randomColor() -> Color {
        
        let color = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}
