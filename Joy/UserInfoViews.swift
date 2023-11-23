//
//  UserInfoViews.swift
//  Joy
//
//  Created by Blair Myers on 11/22/23.
//

import SwiftUI

import SwiftUI

struct UserInfoViews: View {
    @State private var selectedPrimaryItem: SelectionItem?
    @State private var selectedSecondaryItem: SelectionItem?
    @State private var selectedTertiaryItem: SelectionItem?
    @State private var selectedQuaternaryItem: SelectionItem?
    @State private var selectedQuinaryItem: SelectionItem?

    var body: some View {
          SelectionView(title: "Select a few workout activites that interest you",
                        items: primaryItems,
                        selectedItem: $selectedPrimaryItem)
      }

    private func secondarySelectionView(primaryItem: SelectionItem) -> some View {
        SelectionView(title: "Secondary Selection", items: secondaryItems, selectedItem: $selectedSecondaryItem)
            .onAppear {
                self.selectedPrimaryItem = primaryItem
            }
    }

    private func tertiarySelectionView(secondaryItem: SelectionItem) -> some View {
        SelectionView(title: "Tertiary Selection", items: tertiaryItems, selectedItem: $selectedTertiaryItem)
            .onAppear {
                self.selectedSecondaryItem = secondaryItem
            }
    }
}

let primaryItems: [SelectionItem] = [
    SelectionItem(displayText: "Walking", icon: Image(systemName: "figure.walk"), value: "Walking"),
    SelectionItem(displayText: "Running", icon: Image(systemName: "figure.run"), value: "Running"),
    SelectionItem(displayText: "Biking", icon: Image(systemName: "bicycle"), value: "Biking"),
    SelectionItem(displayText: "Yoga", icon: Image(systemName: "person.sitting"), value: "Yoga"),
    SelectionItem(displayText: "Bodyweight Exercises", icon: Image(systemName: "person.3.sequence"), value: "Bodyweight Exercises")
]

let secondaryItems: [SelectionItem] = [
]

let tertiaryItems: [SelectionItem] = [
]

#Preview {
    UserInfoViews()
}

