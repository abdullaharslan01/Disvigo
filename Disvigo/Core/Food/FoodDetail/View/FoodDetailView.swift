//
//  FoodDetailView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct FoodDetailView: View {
    @State var vm: FoodDetailViewModel
    @Environment(GemineViewStateController.self) private var gemine

    @Environment(Router.self) private var router
    @State private var isFavorite: Bool = false
    @Environment(FavoriteManager.self) var favoriteManager

    init(food: Food) {
        self._vm = State(wrappedValue: FoodDetailViewModel(food: food))
    }

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            contentView
        }.preferredColorScheme(.dark)
            .onAppear {
                gemine.isVisible = .visible
                gemine.gemineViewState = .food(vm.food)

                isFavorite = favoriteManager.isFoodFavorite(vm.food)
            }.ignoresSafeArea()
    }

    var contentView: some View {
        ScrollView {
            imageSection
            detailSection
                .padding(.horizontal)
                .padding(.bottom, getSafeArea().bottom + 30)
        }
    }

    var imageSection: some View {
        DImageCollageView(images: vm.food.images, height: 400)
            .overlay(alignment: .topTrailing) {
                FavoriteButtonView(isFavorite: $isFavorite) {
                    favoriteManager.toggleFoodFavorite(vm.food)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        let managerState = favoriteManager.isFoodFavorite(vm.food)
                        if isFavorite != managerState {
                            isFavorite = managerState
                        }
                    }
                }.padding(.top, getSafeArea().top == 0 ? 15 : getSafeArea().top)
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
        .environment(FavoriteManager())
        .environment(GemineViewStateController())
}
