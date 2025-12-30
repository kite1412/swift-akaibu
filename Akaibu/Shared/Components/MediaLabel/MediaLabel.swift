//
//  MediaLabel.swift
//  Akaibu
//
//  Created by kite1412 on 30/12/25.
//

import SwiftUI

struct MediaLabel: View {
    let label: String
    let kind: MediaLabelKind
    
    init(_ label: String, kind: MediaLabelKind) {
        self.label = label
        self.kind = kind
    }
    
    var body: some View {
        Text(label)
            .foregroundStyle(kind.foregroundColor)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(kind.backgroundColor)
            )
            .fontWeight(kind == .adult ? .medium : .regular)
    }
    
    private func label(
        for text: String,
        color: Color,
        backgroundColor: Color
    ) -> some View {
        Text(text)
            .foregroundStyle(color)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(backgroundColor)
            )
    }
}

#Preview {
    MediaLabel("Airing", kind: .status)
}
