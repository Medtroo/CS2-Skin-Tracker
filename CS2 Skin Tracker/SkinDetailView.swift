//
//  SkinDetailView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct SkinDetailView: View {
    let skin: Skin
    @Binding var favoriteSkins: Set<String>
    @Binding var watchlistSkins: Set<String>

    var isFavorite: Bool {
        favoriteSkins.contains(skin.name)
    }

    var isInWatchlist: Bool {
        watchlistSkins.contains(skin.name)
    }

    var body: some View {
        ZStack {
            Color.csBlack
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(skin.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.csOrange)

                    Text("Price: \(skin.price)")
                        .font(.title3)
                        .foregroundStyle(.white)

                    Text("Change: \(skin.change)")
                        .font(.headline)
                        .foregroundStyle(skin.change.contains("-") ? .red : .green)

                    VStack(spacing: 12) {
                        InfoRow(title: "Rarity", value: skin.rarity)
                        InfoRow(title: "Wear", value: skin.wear)
                        InfoRow(title: "Collection", value: skin.collection)
                        InfoRow(title: "Type", value: skin.type)
                        InfoRow(title: "Float", value: skin.floatValue)
                        InfoRow(title: "StatTrak", value: skin.statTrak ? "Yes" : "No")
                    }
                    .padding()
                    .background(Color.csCard)
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                    VStack(spacing: 12) {
                        Button {
                            if isFavorite {
                                favoriteSkins.remove(skin.name)
                            } else {
                                favoriteSkins.insert(skin.name)
                            }
                        } label: {
                            HStack {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                Text(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                            }
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isFavorite ? Color.red : Color.csOrange)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        Button {
                            if isInWatchlist {
                                watchlistSkins.remove(skin.name)
                            } else {
                                watchlistSkins.insert(skin.name)
                            }
                        } label: {
                            HStack {
                                Image(systemName: isInWatchlist ? "eye.slash.fill" : "eye.fill")
                                Text(isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
                            }
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isInWatchlist ? Color.csBlue : Color.csCard)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.csBlue, lineWidth: 1)
                            )
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
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
