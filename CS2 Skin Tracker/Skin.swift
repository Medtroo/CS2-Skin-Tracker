//
//  Skin.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation

struct Skin: Identifiable, Codable, Hashable {
    var id: String { name }

    let name: String
    let price: String
    let change: String
    let rarity: String
    let wear: String
    let collection: String
    let type: String
    let floatValue: String
    let statTrak: Bool
}

extension Skin {
    var numericPrice: Double {
        let cleaned = price
            .replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: ",", with: "")
        return Double(cleaned) ?? 0
    }

    var numericChange: Double {
        let cleaned = change
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: "+", with: "")
        return Double(cleaned) ?? 0
    }
}
