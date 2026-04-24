//
//  WatchListView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct WatchlistView: View {
    let skins: [Skin]
    @Binding var watchlistSkins: Set<String>
    @Binding var favoriteSkins: Set<String>
    
    var watchlistItems: [Skin] {
        skins.filter { watchlistSkins.contains($0.name) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.csBlack
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Watchlist")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.csOrange)
                        
                        Text("Items you’re monitoring for price movement")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                        
                        if watchlistItems.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Your watchlist is empty.")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text("Open an item and tap Add to Watchlist.")
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.csCard)
                            .cornerRadius(16)
                        } else {
                            ForEach(watchlistItems) { skin in
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
