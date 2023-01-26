//
//  Home.swift
//  Colorpicker
//
//  Created by Vitor Trimer on 17/01/23.
//

import SwiftUI

struct Home: View {
    
    @State var currentItem: ColorValue?
    @State var expandCard: Bool = false
    @State var moveCardDown: Bool = false
    
    @Namespace var animation
    
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
            .overlay {
                if let currentItem, expandCard {
                    DetailView(item: currentItem, rectSize: size)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 10)))
                }
            }
        }
        .frame(width: 380, height: 500)
        .preferredColorScheme(.light)
    }
    
    @ViewBuilder
    func DetailView(item: ColorValue, rectSize: CGSize) -> some View {
        ColorView(item: item, rectSize: rectSize)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                
            }
    }
    
    @ViewBuilder
    func CardView(item: ColorValue, rectSize: CGSize) -> some View {
        let tappedCard = item.id == currentItem?.id && moveCardDown
        
        if !(item.id == currentItem?.id && expandCard) {
            ColorView(item: item, rectSize: rectSize)
                .overlay(content: {
                    ColorDetails(item: item)
                })
                .frame(height: 110)
                .contentShape(Rectangle())
                .offset(y: tappedCard ? 30 : 0)
                .zIndex(tappedCard ? 100 : 0)
                .onTapGesture {
                    currentItem = item
                    withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.4)) {
                        moveCardDown = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 1, blendDuration: 1)) {
                            expandCard = true
                        }
                    }
                }
        } else {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 110)
        }
    }
    
    @ViewBuilder
    func ColorView(item: ColorValue, rectSize: CGSize) -> some View {
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
            .matchedGeometryEffect(id: item.id.uuidString, in: animation)
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
