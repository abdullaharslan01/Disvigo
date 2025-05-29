//
//  FoodDetailView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct FoodDetailView: View {
    @State var vm: FoodDetailViewModel

    init(food: Food) {
        self._vm = State(wrappedValue: FoodDetailViewModel(food: food))
    }

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            contentView
        }.preferredColorScheme(.dark)
    }

    var contentView: some View {
        ScrollView {
            imageSection
            detailSection
                .padding(.horizontal)
                .padding(.bottom,getSafeArea().bottom + 30)
        }.ignoresSafeArea()
    }

    var imageSection: some View {
        DImageCollageView(images: vm.food.images, height: 400)
            .overlay(alignment: .top) {
                VStack {
                    DIconButtonView(iconButtonType: .favorite(vm.isFavorite)) {}.padding(.top, getSafeArea().top == 0 ? 15 : getSafeArea().top)
                        .padding(.horizontal)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
    }

    var detailSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(vm.food.title)
                .font(.poppins(.semiBold, size: .largeTitle))

            recipeView

            ExpandableTextView(text: vm.food.description, font: .regular, fontSize: .callout, lineLimit: 20, horizontalPadding: 16)

        }.frame(maxWidth: .infinity, alignment: .leading)
           
    }

    var recipeView: some View {
        Button {
            vm.showSafari.toggle()
        } label: {
            DLabeledIconView(title: String(localized: "View Recipes"), symbolName: AppIcons.food, foregroundStyle: .yellow)
        }.sheet(isPresented: $vm.showSafari) {
            if let url = vm.url {
                DSafariView(url: url)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    FoodDetailView(food: DeveloperPreview.shared.foods[1])
}
