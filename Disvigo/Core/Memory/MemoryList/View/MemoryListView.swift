//
//  MemoryListView.swift
//  Disvigo
//
//  Created by abdullah on 25.05.2025.
//

import SwiftUI

struct MemoryListView: View {
    @State var vm: MemoryListViewModel
    init(memories: [Memory], cityName: String) {
        self._vm = State(wrappedValue: MemoryListViewModel(memories: memories, cityName: cityName))
    }

    @Environment(Router.self) var router

    @Environment(GemineViewStateController.self) private var gemine

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            ScrollView {
                if vm.filteredMemories.isEmpty && !vm.searchText.isEmpty {
                    VStack {
                        Spacer()
                        DEmptyStateView(type: .searchNotFound(title: String(localized: "We couldn't find '\(vm.searchText)' in \(vm.cityName)"))) {
                            vm.searchText = ""
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(0..<((vm.filteredMemories.count + 2) / 3), id: \.self) { groupIndex in
                            let startIndex = groupIndex * 3
                            let endIndex = min(startIndex + 3, vm.filteredMemories.count)
                            let groupMemories = Array(vm.filteredMemories[startIndex..<endIndex])
                            
                            VStack(spacing: 12) {
                                if let firstMemory = groupMemories.first {
                                    MemoryListCardView(memory: firstMemory, onTapGesture: {
                                        router.navigate(to: .memoryDetail(firstMemory))
                                    })
                                    .frame(height: 220)
                                    .id("\(firstMemory.id)-\(vm.searchText)")
                                    .transition(
                                        .asymmetric(
                                            insertion: .opacity.combined(with: .move(edge: .leading)),
                                            removal: .opacity.combined(with: .move(edge: .trailing))
                                        )
                                    )
                                }
                                
                                if groupMemories.count > 1 {
                                    HStack(spacing: 12) {
                                        ForEach(Array(groupMemories.dropFirst()), id: \.id) { memory in
                                            MemoryListCardView(memory: memory, onTapGesture: {
                                                router.navigate(to: .memoryDetail(memory))
                                            })
                                            .frame(height: 160)
                                            .id("\(memory.id)-\(vm.searchText)")
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
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: vm.filteredMemories.map(\.id))
                    .padding(.horizontal)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: vm.filteredMemories.isEmpty && !vm.searchText.isEmpty)
        }
        .onAppear(perform: {
            gemine.isVisible = .visible

        })
        .searchable(
            text: $vm.searchText,
            placement: .navigationBarDrawer,
            prompt: Text(String(localized: "Search \(vm.cityName) memories..."))
        )
        .navigationTitle(String(localized: "\(vm.cityName) Memories"))
        .onChange(of: vm.memories.count) { oldValue, newValue in
            if oldValue != newValue && !vm.searchText.isEmpty {
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }
            vm.previousResultCount = newValue
        }
    }
}

#Preview {
    MemoryListView(memories: DeveloperPreview.shared.memories, cityName: "Adana")
        .environment(Router())
        .environment(GemineViewStateController())
}
