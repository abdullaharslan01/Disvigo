//
//  ContentView.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<50) { i in
                    Text("İçerik \(i)")
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80) 
        }
    }
}

#Preview {
    ContentView()
}
