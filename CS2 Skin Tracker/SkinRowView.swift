//
//  SkinRowView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct SkinRowView: View {
    let skin: Skin

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(skin.name)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("\(skin.type) • \(skin.price)")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
            }

            Spacer()

            Text(skin.change)
                .fontWeight(.semibold)
                .foregroundStyle(skin.change.contains("-") ? .red : .green)
        }
        .padding()
        .background(Color.csCard)
        .cornerRadius(14)
    }
}
