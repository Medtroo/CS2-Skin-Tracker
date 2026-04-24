//
//  FavoritesView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    let skins: [Skin]
    @Binding var favoriteSkins: Set<String>
    @Binding var watchlistSkins: Set<String>

    var favoriteItems: [Skin] {
        skins.filter { favoriteSkins.contains($0.name) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.csBlack
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Favorites")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.csOrange)

                        Text("Your favorite skins")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))

                        if favoriteItems.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("No favorites yet.")
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text("Open a skin and tap Add to Favorites.")
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.csCard)
                            .cornerRadius(16)
                        } else {
                            ForEach(favoriteItems) { skin in
                                NavigationLink {
                                    SkinDetailView(
                                        skin: skin,
                                        favoriteSkins: $favoriteSkins,
                                        watchlistSkins: $watchlistSkins
                                    )
                                } label: {
                                    SkinRowView(skin: skin)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            #endif
        }
    }
}
