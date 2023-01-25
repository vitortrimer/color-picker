//
//  Home.swift
//  Colorpicker
//
//  Created by Vitor Trimer on 17/01/23.
//

import SwiftUI

struct Home: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            let safeArea = proxy.safeAreaInsets
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 8) {
                    ForEach(colors) { color in
                        CardView(item: color, rectSize: size)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
            }
            
            .safeAreaInset(edge: .top) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: safeArea.top + 5)
                    .overlay {
                        Text("Color Picker")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .opacity(0.8)
                    }
                    .overlay(alignment: .trailing) {
                        Text("V1.0.0")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.trailing, 10)
                    }
                
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        .frame(width: 380, height: 500)
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func CardView(item: ColorValue, rectSize: CGSize) -> some View {
        Rectangle()
            .overlay {
                Rectangle()
                    .fill(item.color)
            }
            .overlay {
                Rectangle()
                    .fill(item.color)
                    .rotationEffect(.init(degrees: 180))
            }
            .overlay {
                Rectangle()
                    .fill(item.color.opacity(0.5).gradient)
                    .rotationEffect(.init(degrees: 180))
            }
            .overlay(content: {
                ColorDetails(item: item)
            })
            
            .frame(height: 110)
    }
    
    @ViewBuilder
    func ColorDetails(item: ColorValue) -> some View {
        HStack {
            Text("#\(item.colorCode)")
                .font(.title.bold())
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(item.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text("Hexadecimal")
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .padding([.leading, .vertical, .trailing], 16)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
