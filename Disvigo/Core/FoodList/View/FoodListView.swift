//
//  FoodListView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct FoodListView: View {
    @State var vm: FoodListViewModel
    init(foods: [Food], cityName: String) {
        self._vm = State(wrappedValue: FoodListViewModel(foods: foods, cityName: cityName))
    }

    @Environment(Router.self) var router

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            ScrollView {
                if vm.filteredFoods.isEmpty && !vm.searchText.isEmpty {
                    VStack {
                        Spacer()
                        DEmptyStateView(type: .searchNotFound(title: String(localized: "No dish found with \(vm.searchText)"))) {
                            vm.searchText = ""
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(0..<((vm.filteredFoods.count + 2) / 3), id: \.self) { groupIndex in
                            let startIndex = groupIndex * 3
                            let endIndex = min(startIndex + 3, vm.filteredFoods.count)
                            let groupFoods = Array(vm.filteredFoods[startIndex..<endIndex])

                            VStack(spacing: 12) {
                                if groupFoods.count >= 2 {
                                    HStack(spacing: 12) {
                                        ForEach(Array(groupFoods.prefix(2)), id: \.id) { food in
                                            FoodListCardView(food: food) {
                                                router.navigate(to: .foodDetail(food))
                                            }
                                            .frame(height: 160)
                                            .id("\(food.id)-\(vm.searchText)")
                                            .transition(
                                                .asymmetric(
                                                    insertion: .opacity.combined(with: .move(edge: .leading)),
                                                    removal: .opacity.combined(with: .move(edge: .trailing))
                                                )
                                            )
                                        }
                                    }
                                } else if let firstFood = groupFoods.first {
                                    HStack {
                                        FoodListCardView(food: firstFood) {
                                            router.navigate(to: .foodDetail(firstFood))
                                        }
                                        .frame(height: 160)
                                        .id("\(firstFood.id)-\(vm.searchText)")
                                        .transition(
                                            .asymmetric(
                                                insertion: .opacity.combined(with: .move(edge: .leading)),
                                                removal: .opacity.combined(with: .move(edge: .trailing))
                                            )
                                        )
                                        Spacer()
                                    }
                                }

                                if groupFoods.count > 2, let thirdFood = groupFoods.last {
                                    FoodListCardView(food: thirdFood) {
                                        router.navigate(to: .foodDetail(thirdFood))
                                    }
                                    .frame(height: 220)
                                    .id("\(thirdFood.id)-\(vm.searchText)")
                                    .transition(
                                        .asymmetric(
                                            insertion: .opacity.combined(with: .move(edge: .leading)),
                                            removal: .opacity.combined(with: .move(edge: .trailing))
                                        )
                                    )
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: vm.filteredFoods.map(\.id))
                    .padding(.horizontal)
                    .padding(.top,30)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: vm.filteredFoods.isEmpty && !vm.searchText.isEmpty)
        }
        .searchable(
            text: $vm.searchText,
            placement: .navigationBarDrawer,
            prompt: Text("Search \(vm.cityName) dishes...")
        )
        .navigationTitle(String(localized: "\(vm.cityName) Flavors"))
        .onChange(of: vm.filteredFoods.count) { oldValue, newValue in
            if oldValue != newValue && !vm.searchText.isEmpty {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
            vm.previousResultCount = newValue
        }
    }
}

#Preview {
    NavigationStack {
        FoodListView(foods: DeveloperPreview.shared.foods, cityName: "Adana")
            .environment(Router())
    }
}
