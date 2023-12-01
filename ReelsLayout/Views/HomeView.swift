//
//  HomeView.swift
//  ReelsLayout
//
//  Created by darktech4 on 30/11/2023.
//

import SwiftUI
import Foundation

struct HomeView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    @State private var reels: [Reel] = reelsData
    @State private var likeCounter: [Like] = []
    
    var body: some View {
        ScrollView(.vertical){
            ForEach($reels){ $reel in
                ReelView(reel: $reel, likeCounter: $likeCounter, size: size, safeArea: safeArea)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .containerRelativeFrame(.vertical)
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background(.black)
        .overlay(alignment: .topLeading,content: {
            ZStack{
                ForEach(likeCounter, id: \.id){ like in
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 75))
                        .foregroundStyle(.red.gradient)
                        .frame(width: 100, height: 100)
                        .animation(.smooth, body: { view in
                            view
                                .scaleEffect(like.animated ? 1 : 1.8)
                                .rotationEffect(.init(degrees: like.animated ? 0 : .random(in: -30...30)))
                        })
                        .offset(x: like.tappedRect.x - 50, y: like.tappedRect.y - 50)
                    /// let animation
                        .offset(y: like.animated ? -(like.tappedRect.y + safeArea.top) : 0 )
                }
            }
        })
        .overlay(alignment: .top, content: {
            Text("Reels")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .padding(.top, safeArea.top + 15)
                .padding(.horizontal, 15)
        })
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
