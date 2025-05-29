//
//  MemoryDetailView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import MapKit
import SwiftUI

struct MemoryDetailView: View {
    @State var vm: MemoryDetailViewModel
    @State private var showMapOptions = false
    
    init(memory: Memory) {
        self._vm = State(wrappedValue: MemoryDetailViewModel(memory: memory))
    }
    
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            contentView
        }
        .preferredColorScheme(.dark)
        .confirmationDialog("Select Map App", isPresented: $showMapOptions) {
            mapSelectionButtons
        } message: {
            Text(String(localized:"Select Map App to show vendors near you."))
        }
    }
    
    var contentView: some View {
        ScrollView {
            imageSection
            detailSection
                .padding(.horizontal)
                .padding(.bottom,getSafeArea().bottom + 30)

        }
        .ignoresSafeArea()
    }
    
    var imageSection: some View {
        DImageCollageView(images: vm.memory.images, height: 400)
            .overlay(alignment: .top) {
                VStack {
                    DIconButtonView(iconButtonType: .favorite(vm.isFavorite)) {}
                        .padding(.top, getSafeArea().top == 0 ? 15 : getSafeArea().top)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
    }
    
    var detailSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(vm.memory.title)
                .font(.poppins(.semiBold, size: .largeTitle))
            
            recipeView
            
            ExpandableTextView(
                text: vm.memory.description,
                font: .regular,
                fontSize: .callout,
                lineLimit: 20,
                horizontalPadding: 16
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var recipeView: some View {
        Button {
            showMapOptions = true
        } label: {
            DLabeledIconView(
                title: String(localized: "Show \(vm.memory.title.components(separatedBy: .whitespaces).first ?? "") Sellers Nearby"),
                symbolName: AppIcons.locationDetail,
                foregroundStyle: .mint
            )
        }
    }
    
    var mapSelectionButtons: some View {
        Group {
            Button(String(localized: "Search in Apple Maps")) {
                MapManager.shared.openAppleMaps(searchQuery: "\(vm.memory.title)")
            }
            
            Button(String(localized: "Search in Google Maps")) {
                MapManager.shared.openGoogleMaps(searchQuery: "\(vm.memory.title)")
            }
            
            Button(String(localized: "Cancel"), role: .cancel) {}
        }
    }
}

#Preview {
    MemoryDetailView(memory: DeveloperPreview.shared.memories[1])
}
