//
//  ItemPicker.swift
//  Akaibu
//
//  Created by kite1412 on 21/02/26.
//

import SwiftUI

struct ItemPicker: View {
    @Binding var selected: String
    let selections: [String]
    var onSelectedChange: (String) -> Void
    var horizontalPadding: CGFloat?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(selections, id: \.self) { item in
                        let isSelected = selected == item
                        
                        Text(item)
                            .id(item)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(isSelected ? .accent : .clear)
                            )
                            .animation(.easeInOut(duration: 0.3), value: isSelected)
                            .foregroundStyle(
                                isSelected ? .white : .primary
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selected = item
                                }
                            }
                    }
                }
                .onChange(of: selected) { _, newValue in
                    onSelectedChange(newValue)
                }
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.thinMaterial)
                )
                .applyIf(horizontalPadding != nil) { view in
                    view.padding(.horizontal, horizontalPadding!)
                }
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(
                id: Binding<String?>(
                    get: { selected },
                    set: { selected = $0 ?? selected }
                )
            )
            .scrollIndicators(.hidden)
            .onAppear {
                proxy.scrollTo(selected, anchor: .trailing)
            }
        }
    }
}

#Preview {
    @Previewable @State var selected: String = "All"
    
    ItemPicker(
        selected: $selected,
        selections: ["All", "Completed", "On Hold"],
        onSelectedChange: { _ in }
    )
}
