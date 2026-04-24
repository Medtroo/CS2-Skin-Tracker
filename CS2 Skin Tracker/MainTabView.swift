//
//  MainTabView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct MainTabView: View {
    @State private var skins: [Skin] = SkinLoader.loadSkins()
    @State private var favoriteSkins: Set<String> = []
    @State private var watchlistSkins: Set<String> = []
    @State private var searchText = ""
    @State private var selectedFilter: SkinFilter = .all
    @State private var selectedSort: SkinSortOption = .defaultOrder

    var body: some View {
        TabView {
            HomeView(
                skins: skins,
                favoriteSkins: $favoriteSkins,
                watchlistSkins: $watchlistSkins,
                searchText: $searchText,
                selectedFilter: $selectedFilter,
                selectedSort: $selectedSort
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            FavoritesView(
                skins: skins,
                favoriteSkins: $favoriteSkins,
                watchlistSkins: $watchlistSkins
            )
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }

            WatchlistView(
                skins: skins,
                watchlistSkins: $watchlistSkins,
                favoriteSkins: $favoriteSkins
            )
            .tabItem {
                Label("Watchlist", systemImage: "eye.fill")
            }
        }
        .tint(Color.csOrange)
    }
}

#Preview {
    MainTabView()
}
