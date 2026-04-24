//
//  SkinSortOption.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation

enum SkinSortOption: String, CaseIterable, Identifiable {
    case defaultOrder = "Default"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"
    case nameAZ = "Name: A-Z"

    var id: String { rawValue }
}
