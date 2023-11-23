//
//  SelectionView.swift
//  Joy
//
//  Created by Blair Myers on 11/18/23.
//

import SwiftUI

struct SelectionItem: Identifiable {
    let id = UUID()
    var displayText: String
    var icon: Image
    var value: Any
}

struct SelectionRowView: View {
    var item: SelectionItem
    var isSelected: Bool
    
    var body: some View {
        HStack {
            item.icon
                .resizable()
                .frame(width: 30, height: 30)
            Text(item.displayText)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(isSelected ? Color.gray.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 3)
    }
}

struct SelectionView: View {
    var title: String
    var items: [SelectionItem]
    @Binding var selectedItem: SelectionItem?

    var body: some View {
        VStack {
            Spacer(minLength: 20)
            
            Text(title)
                .font(.headline)
                .padding(.bottom, 20)
            
            List(items) { item in
                Button(action: {
                    self.selectedItem = item
                }) {
                    SelectionRowView(item: item, isSelected: selectedItem?.id == item.id)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listStyle(GroupedListStyle())
            
            Button(action: {
            }) {
                Text("CONTINUE")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedItem != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .padding()
                    .disabled(selectedItem == nil)
            }
        }
        .navigationBarHidden(true)
    }
}

struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let office = SelectionItem(displayText: "Office", icon: Image(systemName: "building.2"), value: "Office")
        let home = SelectionItem(displayText: "Home", icon: Image(systemName: "house"), value: "Home")
        let outdoors = SelectionItem(displayText: "Outdoors", icon: Image(systemName: "leaf.arrow.circlepath"), value: "Outdoors")
        var selectionItems: [SelectionItem] = [office, home, outdoors]
        
        SelectionView(title: "Select the option that best describes your work setting?", items: selectionItems, selectedItem: .constant(selectionItems[0]))
    }
}
