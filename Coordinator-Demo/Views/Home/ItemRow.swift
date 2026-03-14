//
//  ItemRow.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    let isFavorite: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: item.iconName)
                .font(.title2)
                .foregroundStyle(.primary)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                    .foregroundStyle(.primary)
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundStyle(Color(.systemGray3))
            }

            Spacer()

            if isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
}
