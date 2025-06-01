//
//  AddListView.swift
//  Disvigo
//
//  Created by abdullah on 31.05.2025.
//

import SwiftUI

struct AddListView: View {
    let isUpdate: Bool
    var visitedList: VisitedList?
    
    @State private var listName = ""
    @State private var symbolName = "sailboat"

    @State private var color = Color.appGreenPrimary
    @State private var showIconPicker = false
    @State private var rotation = 0.0
    let rainbowColors = [Color.yellow, Color.orange, Color.red, Color.purple, Color.blue, Color.green]
    @State private var showAlert = false
    @State private var successAlert = false
    @State private var alertMessage = ""
    @FocusState private var isNameFieldFocused: Bool?
    
    @Environment(FavoriteManager.self) var visitedManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.appBackgroundDark.ignoresSafeArea()

            VStack(spacing: 30) {
                headerSection
                nameSection
                selectionSection
                saveButton
                
                Spacer()
            }
            .padding()
            .onTapGesture {
                isNameFieldFocused = true
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
        .onAppear(perform: setupData)
        .alert(String(localized: "Warning"), isPresented: $showAlert) {
            Button(String(localized: "OK")) {}
        } message: {
            Text(alertMessage)
        }
        .alert(String(localized: "Successfully added"), isPresented: $successAlert) {
            Button(String(localized: "OK")) {
                dismiss()
            }
        } message: {
            Text(alertMessage)
        }
        .fullScreenCover(isPresented: $showIconPicker) {
            IconPickerView(selectedIcon: $symbolName)
        }
    }
    
    private var headerSection: some View {
        ZStack {
            closeButton.frame(maxWidth: .infinity, alignment: .leading)
            
            Text(isUpdate ? String(localized: "Edit Adventure") : String(localized: "New Adventure"))
                .font(.poppins(.semiBold, size: .title))
        }
    }
    
    private var closeButton: some View {
        DIconButtonView(
            iconButtonType: .custom(AppIcons.xmark),
            iconColor: .appTextLight,
            bgColor: .red
        ) {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            dismiss()
        }
    }
    
    private var nameSection: some View {
        VStack(alignment: .leading) {
            Text(String(localized: "Adventure Name"))
                .font(.poppins(.regular, size: .body))
                .foregroundStyle(.appTextLight)
            
            TextField(String(localized: "Enter name"), text: $listName)
                .focused($isNameFieldFocused, equals: true)
                .font(.poppins(.semiBold, size: .headline))
                .padding()
                .frame(height: 55)
                .autocorrectionDisabled()
                .background(.appTextLight, in: .rect(cornerRadius: 6))
                .foregroundStyle(.appBackgroundDeep)
                .submitLabel(.done)
        }
    }
    
    var selectionSection: some View {
        HStack(spacing: 15) {
            VStack {
                Text(String(localized: "Choose an Icon"))
                    .font(.poppins(.regular, size: .body))
                    .foregroundStyle(.appTextLight)
                    .multilineTextAlignment(.center)
                        
                Spacer()
                        
                Image(systemName: symbolName)
                    .symbolEffect(.pulse, isActive: true)
                    .font(.poppins(.regular, size: .largeTitle))
                    .foregroundStyle(color)
                        
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16).stroke()
            }
            .overlay(
                Button {
                    showIconPicker = true
                } label: {
                    Rectangle()
                        .fill(Color.clear)
                }
            )
                
            VStack {
                Text(String(localized: "Select Color"))
                    .font(.poppins(.regular, size: .body))
                    .foregroundStyle(.appTextLight)
                    .multilineTextAlignment(.center)
                        
                Spacer()
                        
                Circle()
                    .fill(color)
                    .background(
                        Circle()
                            .stroke(.white, lineWidth: 4)
                            .background(
                                Circle()
                                    .stroke(LinearGradient(colors: rainbowColors, startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 10)
                                    .shadow(color: .pink.opacity(0.4), radius: 5)
                                    .rotationEffect(.degrees(rotation))
                                    .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: rotation)
                                    .onAppear {
                                        rotation = 360
                                    }
                            )
                    )
                    .frame(width: 30, height: 30)
                        
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 16).stroke()
            }
            .overlay(
                ColorPicker("", selection: $color)
                    .labelsHidden()
                    .blur(radius: 20)
                    .scaleEffect(x: 20, y: 2)
                    .opacity(0.1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            )
        }
    }

    private var saveButton: some View {
        Button(action: handleSave) {
            Text(isUpdate ? String(localized: "Save Changes") : String(localized: "Create List"))
                .font(.poppins(.medium, size: .headline))
                .padding()
                .foregroundStyle(.appTextLight)
                .frame(maxWidth: .infinity)
                .background(.appGreenPrimary, in: RoundedRectangle(cornerRadius: 16))
        }
        .disabled(listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        .opacity(listName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1.0)
    }
    
    private func setupData() {
        guard isUpdate, let list = visitedList else { return }
        listName = list.name
        symbolName = list.symbolName
        color = list.color
    }
    
    private func handleSave() {
        let result: (Bool, String)
        
        if isUpdate, let list = visitedList {
            result = visitedManager.updateList(list, name: listName, symbolName: symbolName, color: color)
        } else {
            result = visitedManager.createList(name: listName, symbolName: symbolName, color: color)
        }
        
        if result.0 {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            alertMessage = result.1
            successAlert = true
            
        } else {
            alertMessage = result.1
            showAlert = true
        }
    }
}

#Preview {
    AddListView(isUpdate: false)
        .environment(FavoriteManager())
}
