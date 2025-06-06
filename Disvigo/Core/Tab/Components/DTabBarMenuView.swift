//
//  DTabBarMenuView.swift
//  Disvigo
//
//  Created by abdullah on 04.06.2025.
//

import SwiftUI

enum TabType: String, CaseIterable, Identifiable {
    case home
    case favorites
    case visited

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return String(localized: "Home")
        case .favorites: return String(localized: "Favorites")
        case .visited: return String(localized: "Visited")
        }
    }

    var iconNormal: String {
        switch self {
        case .home: return AppIcons.home
        case .favorites: return AppIcons.heart
        case .visited: return AppIcons.unCheckedAllList
        }
    }

    var iconFill: String {
        switch self {
        case .home: return AppIcons.homeFill
        case .favorites: return AppIcons.heartFill
        case .visited: return AppIcons.checkedAllList
        }
    }
}

struct DTabBarMenuView: View {
    @Namespace private var tabNameSpace
    @Binding var currentTab: TabType
    @Binding var isVisible: Bool

    var body: some View {
        ZStack {
            if isVisible {
                tabBarContent
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
        }
        .animation(.default, value: isVisible)
    }

    private var tabBarContent: some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases) { tab in
                tabItem(tab)
            }
        }
        .padding(.bottom, getSafeArea().bottom == 0 ? 5 : getSafeArea().bottom )
        .background(.appBackgroundDeep)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -2)
    }

    @ViewBuilder
    func tabItem(_ item: TabType) -> some View {
        Button {
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()

            withAnimation(.bouncy(extraBounce: 0.1)) {
                currentTab = item
            }
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 3)

                    if item == currentTab {
                        Rectangle()
                            .fill(.appGreenPrimary)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "indicator", in: tabNameSpace)
                    }
                }

                VStack(spacing: 4) {
                    Image(systemName: currentTab == item ? item.iconFill : item.iconNormal)
                        .font(.poppins(.regular, size: .title3))
                        .scaleEffect(currentTab == item ? 1.1 : 1.0)

                    Text(item.title)
                        .font(.poppins(.regular, size: .caption))
                        .lineLimit(1)
                }
                
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .foregroundStyle(item == currentTab ? .appGreenPrimary : .appTextLight)
        }
        .buttonStyle(TabButtonStyle())
    }
}

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundDark.ignoresSafeArea()
        DTabBarMenuView(currentTab: .constant(.favorites), isVisible: .constant(true))
    }
}

struct AdaptableHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }

        value = nextValue
    }
}

struct AdaptableHeightModifier: ViewModifier {

    @Binding var currentHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .background(

                GeometryReader { geometry in
                    Color.clear
                        .preference(key: AdaptableHeightPreferenceKey.self, value: geometry.size.height)
                }
            )
            .onPreferenceChange(AdaptableHeightPreferenceKey.self) { height in
                if let height {
                    currentHeight = height
                }
            }
    }
}

extension View {
    func readAndBindHeight(to height: Binding<CGFloat>) -> some View {
        self.modifier(AdaptableHeightModifier(currentHeight: height))
    }
}
