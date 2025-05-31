//
//  IconPickerView.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    @Environment(\.dismiss) private var dismiss
    
    let baseIcons = [
        // Uçak en başta + Temel Ulaşım
        
        "sailboat",
        "airplane",
        "car",
        "train.side.front.car",
        "bus",
        "ferry",
        "bicycle",
        "scooter",
        "airplane.departure",
        "airplane.arrival",
        
        "airplane.circle",
        "car.circle",
        "train.side.middle.car",
        "tram",
        "motorcycle",
        "cablecar",
        "fuelpump",
        "parkingsign",
        
        // Binalar
        "building.2",
        "building.columns",
        "house",
        "globe",
        "building",
        "storefront",
        
        "map",
        "mappin",
        "flag",
        "star",
        "compass.drawing",
        
        "cross",
        "crown",
        "rosette",
        "medal",
        "trophy",
        "sparkles",
        "wand.and.rays",
        "graduationcap",
        
        "person",
        "person.2",
        "person.3",
        "figure.walk",
        "figure.run",
        "figure.hiking",
        "figure.skiing.downhill",
        "hand.wave",
        "hand.thumbsup",
        
        "tree",
        "leaf",
        "mountain.2",
        "water.waves",
        "sun.max",
        "cloud.sun",
        "snowflake",
        "flame",
        "beach.umbrella",
        "tent",
        "sun.min",
        "cloud",
        "cloud.rain",
        "cloud.snow",
        "wind",
        "hurricane",
        "thermometer",
        "umbrella",
        
        "fork.knife",
        "cup.and.saucer",
        "wineglass",
        "birthday.cake",
        "takeoutbag.and.cup.and.straw",
        "fish",
        "carrot",
        "mug",
        "popcorn",
        
        "camera",
        "binoculars",
        "gamecontroller",
        "theatermasks",
        "music.note",
        "sportscourt",
        "basketball",
        "football",
        "dumbbell",
        "tennis.racket",
        "baseball",
        "volleyball",
        "cricket.ball",
        "hockey.puck",
        "figure.surfing",
        "figure.skiing.crosscountry",
        "figure.snowboarding",
        "figure.fishing",
        "figure.golf",
        
        "bed.double",
        "key",
        "bag",
        "cart",
        "gift",
        "creditcard",
        "dollarsign.circle",
        "percent",
        "tag",
        "door.left.hand.open",
        "banknote",
        "door.garage.open",
        "basket",
        "bag.badge.plus",
        "cart.badge.plus",
        "receipt",
        "wallet.pass",
        "giftcard",
        "ticket",
        
        "calendar",
        "clock",
        "timer",
        "bookmark",
        "heart",
        "checkmark.circle",
        "list.bullet",
        "doc.text",
        "folder",
        "magnifyingglass",
        "calendar.circle",
        "note.text",
        "clipboard",
        "archivebox",
        "tray",
        "paperplane",
        "envelope.open",
        "pencil.and.ruler",
        "ruler",
        
        "diamond",
        "hexagon",
        "circle",
        "square",
        "triangle",
        "infinity",
        "peacesign",
        "drop",
        "eye",
        "heart.rectangle",
        
        "phone",
        "message",
        "envelope",
        "wifi",
        "antenna.radiowaves.left.and.right",
        "qrcode",
        "barcode",
        "camera.viewfinder",
        "video",
        "headphones",
        "speaker.wave.2",
        "airpods",
        "desktopcomputer",
        "laptopcomputer",
        "iphone",
        "ipad",
        "applewatch",
        "tv",
        "radio",
        
        "square.and.arrow.up",
        "link",
        "photo.on.rectangle",
        "shared.with.you",
        "heart.text.square",
        "quote.bubble",
        "text.bubble",
        "captions.bubble",
        "star.bubble",
        "bell",
        
        "exclamationmark.triangle",
        "info.circle",
        "questionmark.circle",
        "checkmark.seal",
        "bolt",
        "lightbulb",
        "gear",
        "slider.horizontal.3",
        "plus.circle",
        "minus.circle",
        
        "book",
        "books.vertical",
        "studentdesk",
        "pencil",
        "paintbrush",
        "camera.macro",
        "globe.desk",
        "newspaper",
        
        "cross.case",
        "stethoscope",
        "pills",
        "bandage",
        "syringe",
        "medical.thermometer",
        "heart.text.clipboard",
        "shield",
        "lock",
        "cross.circle",
        
        "music.quarternote.3",
        "music.mic",
        "paintpalette",
        "photo.artframe",
        "theatermask.and.paintbrush",
        "music.note.house",
        "headphones.circle",
        "mic.circle"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackgroundDark.ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5), spacing: 16) {
                        ForEach(Array(baseIcons.enumerated()), id: \.offset) { _, iconName in
                            Button(action: {
                                selectedIcon = iconName
                                dismiss()
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedIcon == iconName ? Color.blue : Color.gray.opacity(0.08))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedIcon == iconName ? Color.blue : Color.clear, lineWidth: 2)
                                        )
                                        .frame(width: 60, height: 60)
                                    
                                    Image(systemName: iconName)
                                        .font(.system(size: 25))
                                        .foregroundColor(selectedIcon == iconName ? .white : .primary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .preferredColorScheme(.dark)
            .navigationTitle(String(localized: "Choose Icon"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
            }
        }
    }
}

#Preview {
    IconPickerView(selectedIcon: .constant("airplane"))
}
