//
//  HomeView.swift
//  CS2 Skin Tracker
//
//  Created by Nika Metreveli on 4/22/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let skins: [Skin]
    @Binding var favoriteSkins: Set<String>
    @Binding var watchlistSkins: Set<String>
    @Binding var searchText: String
    @Binding var selectedFilter: SkinFilter
    @Binding var selectedSort: SkinSortOption

    var filteredSkins: [Skin] {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let searchedSkins: [Skin]
        if trimmedText.isEmpty {
            searchedSkins = skins
        } else {
            searchedSkins = skins.filter { skin in
                skin.name.localizedCaseInsensitiveContains(trimmedText) ||
                skin.type.localizedCaseInsensitiveContains(trimmedText) ||
                skin.collection.localizedCaseInsensitiveContains(trimmedText)
            }
        }

        let typeFilteredSkins: [Skin]
        if selectedFilter == .all {
            typeFilteredSkins = searchedSkins
        } else if selectedFilter == .weapons {
            typeFilteredSkins = searchedSkins.filter { skin in
                skin.type == "Rifle" ||
                skin.type == "Sniper Rifle" ||
                skin.type == "Pistol"
            }
        } else {
            typeFilteredSkins = searchedSkins.filter { skin in
                skin.type == selectedFilter.rawValue
            }
        }

        switch selectedSort {
        case .defaultOrder:
            return typeFilteredSkins
        case .priceLowToHigh:
            return typeFilteredSkins.sorted { $0.numericPrice < $1.numericPrice }
        case .priceHighToLow:
            return typeFilteredSkins.sorted { $0.numericPrice > $1.numericPrice }
        case .nameAZ:
            return typeFilteredSkins.sorted { $0.name < $1.name }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.csBlack
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Home")
                            .font(.headline)
                            .foregroundStyle(Color.csOrange)

                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("CS2 Skin Tracker")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.csOrange)

                                Text("Track prices, favorites, and market trends")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.8))
                            }

                            Spacer()

                            Image(systemName: "shield.lefthalf.filled")
                                .font(.title)
                                .foregroundStyle(Color.csBlue)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Search Skins")
                                .font(.headline)
                                .foregroundStyle(Color.csOrange)

                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.csBlue)

                                TextField(
                                    "",
                                    text: $searchText,
                                    prompt: Text("Search by skin name, type, or collection...")
                                        .foregroundStyle(.white.opacity(0.45))
                                )
                                .foregroundStyle(.white)
                                .tint(Color.csBlue)
                            }
                            .padding()
                            .background(Color.csCard)
                            .cornerRadius(12)
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Filter")
                                .font(.headline)
                                .foregroundStyle(Color.csOrange)

                            Picker("Filter", selection: $selectedFilter) {
                                ForEach(SkinFilter.allCases) { filter in
                                    Text(filter.rawValue).tag(filter)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .background(Color.csCard)
                            .cornerRadius(12)

                            Text("Sort")
                                .font(.headline)
                                .foregroundStyle(Color.csOrange)

                            Picker("Sort", selection: $selectedSort) {
                                ForEach(SkinSortOption.allCases) { option in
                                    Text(option.rawValue).tag(option)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .background(Color.csCard)
                            .cornerRadius(12)
                        }

                        HStack(spacing: 12) {
                            VStack(spacing: 8) {
                                Text("\(skins.count)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)

                                Text("Tracked")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.csCard)
                            .cornerRadius(16)

                            VStack(spacing: 8) {
                                Text("\(favoriteSkins.count)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)

                                Text("Favorites")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.csCard)
                            .cornerRadius(16)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Items")
                                .font(.headline)
                                .foregroundStyle(Color.csOrange)

                            if skins.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("No items loaded yet.")
                                        .foregroundStyle(.white)

                                    Text("Make sure skins.json is added to the project target.")
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.csCard)
                                .cornerRadius(14)
                            } else if filteredSkins.isEmpty {
                                Text("No skins found.")
                                    .foregroundStyle(.white.opacity(0.7))
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.csCard)
                                    .cornerRadius(14)
                            } else {
                                ForEach(filteredSkins) { skin in
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
                    }
                    .padding()
                }
            }
            .navigationTitle("Home")
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            #endif
        }
    }
}
