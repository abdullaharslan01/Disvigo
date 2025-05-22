//
//  CityDetailView.swift
//  Disvigo
//
//  Created by abdullah on 22.05.2025.
//

import MapKit
import SwiftUI

struct CityDetailView: View {
    let city: City

    @State private var showFullDescription = false
    @Environment(Router.self) private var router
    @State private var showSafari = false

    @State var position: MapCameraPosition = .automatic
    @State var didAppeear = false

    var url: URL? {
        let baseURL = "https://tr.wikipedia.org/wiki/"

        var cityName = ""

        switch city.name {
        case "Tokat", "Ordu":
            cityName = city.name + "_(şehir)"
        default:
            cityName = city.name
        }

        return URL(string: baseURL + cityName)
    }

    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()
            ScrollView {
                VStack {
                    cityImageView

                    cityContentView

                    
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .ignoresSafeArea(edges: [.top])
            .preferredColorScheme(.dark)
        }
    }

    var cityImageView: some View {
        DImageLoaderView(url: city.imageUrl, contentMode: .fill)
            .frame(height: 360)
    }

    var cityContentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            if didAppeear {
                VStack(alignment: .leading, spacing: 25) {
                    headerTextView
                        .transition(.flipFromLeft(duration: 0.5))
                    moreDetailView
                        .transition(.slide)
                    descriptionView
                        .transition(.slide)
                }.padding()

                categoryView
                    .transition(.slide)
                
                cityMapView
            }
        }
        .padding(.top, 5)
        .background(.appBackgroundDark)
        .clipShape(UnevenRoundedRectangle(cornerRadii: .init(topLeading: 32, bottomLeading: 0, bottomTrailing: 0, topTrailing: 32)))
        .offset(y: -50)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                didAppeear = true
                position = .region(.init(center: city.coordinates.clLocationCoordinate2D, latitudinalMeters: 5000, longitudinalMeters: 5000))
            }
        }
    }

    var headerTextView: some View {
        Text(city.name)
            .font(.poppins(.semiBold, size: .largeTitle))
            .fontWeight(.bold)
    }

    var moreDetailView: some View {
        VStack(alignment: .leading, spacing: 16) {
            DLabeledIconView(title: city.region, symbolName: AppIcons.location)

            Button {
                showSafari.toggle()
            } label: {
                DLabeledIconView(title: String(localized: "Learn More"), symbolName: AppIcons.safari, foregroundStyle: .blue)
            }
        }.sheet(isPresented: $showSafari) {
            if let url {
                DSafariView(url: url)
                    .presentationDragIndicator(.visible)
            }
        }
    }

    var descriptionView: some View {
        VStack(alignment: .leading) {
            Text(city.description)
                .font(.poppins(.light, size: .body))
                .lineSpacing(4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(showFullDescription ? nil : 3)

            if isDescriptionTruncated() {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showFullDescription.toggle()
                    }
                }) {
                    Text(showFullDescription ? String(localized: "Show Less") : String(localized: "Read More"))
                        .font(.poppins(.medium, size: .callout))
                        .foregroundColor(.accent)
                        .padding(.vertical, 4)
                }
            }
        }
    }

    var categoryView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Category.allCases, id: \.id) { category in

                    DCategoryCardView(category: category, size: .init(width: 180, height: 250)) {}
                }
            }.padding(.horizontal)
        }.scrollIndicators(.hidden)
            .frame(height: 220)
    }

    var cityMapView: some View {
        Map(position: $position) {}.frame(height: 250)
            .frame(maxWidth: .infinity)
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
            .padding(.top,30)
    }
}

extension CityDetailView {
    private func isDescriptionTruncated() -> Bool {
        let text = city.description
        let font = UIFont(name: "Poppins-Light", size: 16) ?? UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]

        let constraintRect = CGSize(width: UIScreen.main.bounds.width - 32,
                                    height: .greatestFiniteMagnitude)

        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: attributes,
                                            context: nil)

        return boundingBox.height > font.lineHeight * 3
    }
}

#Preview {
    NavigationStack {
        CityDetailView(city: DeveloperPreview.shared.city)
    }
    .environment(Router())
}
