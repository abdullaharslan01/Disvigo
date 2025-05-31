//
//  VisitedDetailView.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftUI

struct VisitedDetailView: View {
    let visitedList: VisitedList
    
    @Environment(VisitedManager.self) var visitedManager
    @State private var editListState: Bool = false
    
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            
            List {
                // Your list content here
            }
            .navigationTitle(visitedList.name)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String(localized: "Edit")) {
                        editListState.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $editListState) {
                AddListView(isUpdate: true, visitedList: visitedList)
            }
        }
    }
}

#Preview {
    NavigationStack {
        VisitedDetailView(visitedList: .init(name: "a"))
            .environment(VisitedManager())
    }
}
