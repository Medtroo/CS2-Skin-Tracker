//
//  SkinFilter.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation

enum SkinFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case rifle = "Rifle"
    case sniperRifle = "Sniper Rifle"
    case pistol = "Pistol"
    case knife = "Knife"
    case gloves = "Gloves"
    case caseItem = "Case"
    case weapons = "Weapons"

    var id: String { rawValue }
}
