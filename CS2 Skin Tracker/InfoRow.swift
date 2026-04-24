//
//  InfoRow.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(Color.csBlue)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
}
