//
//  FoodDetailView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct FoodDetailView: View {
    var isFavorite: Bool {
        return false
    }

    @State var showSafari = false
    let food: Food
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            contentView
        }.preferredColorScheme(.dark)
    }

    var url: URL? {
        let query = food.title
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .joined(separator: "+")
        return URL(string: "https://www.nefisyemektarifleri.com/ara/?s=\(query)")
    }

    var contentView: some View {
        ScrollView {
            imageSection
            detailSection
                .padding(.horizontal)
        }.ignoresSafeArea()
    }

    var imageSection: some View {
        DImageCollageView(images: food.images, height: 400)
            .overlay(alignment: .top) {
                VStack {
                    DIconButtonView(iconButtonType: .favorite(isFavorite)) {}.padding(.top, getSafeArea().top == 0 ? 15 : getSafeArea().top)
                        .padding(.horizontal)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
    }

    var detailSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(food.title)
                .font(.poppins(.semiBold, size: .largeTitle))

            recipeView
            
            ExpandableTextView(text: food.description, font: .regular, fontSize: .callout, lineLimit: 4, horizontalPadding: 16)

        }.frame(maxWidth: .infinity, alignment: .leading)
    }

    var recipeView: some View {
        Button {
            showSafari.toggle()
        } label: {
            DLabeledIconView(title: String(localized: "View Recipes"), symbolName: AppIcons.food, foregroundStyle: .yellow)
        }.sheet(isPresented: $showSafari) {
            if let url  {
                DSafariView(url: url)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    FoodDetailView(food: DeveloperPreview.shared.foods[1])
}
