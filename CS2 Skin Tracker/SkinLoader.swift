//
//  SkinLoader.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation

struct SkinLoader {
    static func loadSkins() -> [Skin] {
        guard let url = Bundle.main.url(forResource: "skins", withExtension: "json") else {
            print("Could not find skins.json in bundle.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Skin].self, from: data)
            return decoded
        } catch {
            print("Failed to load skins.json: \(error)")
            return []
        }
    }
}
