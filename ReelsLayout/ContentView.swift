//
//  ContentView.swift
//  ReelsLayout
//
//  Created by darktech4 on 30/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            GeometryReader{
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                HomeView(size: size, safeArea: safeArea)
                    .ignoresSafeArea(.container, edges: .all)
            }
        }
    }
}

#Preview {
    ContentView()
}
