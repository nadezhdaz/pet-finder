//
//  ContentView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var homeViewModel: HomeViewModel = HomeViewModel(apiClient: PetFinderApiClient())

    var body: some View {
        HomeView<HomeViewModel>(with: homeViewModel)
    }
}
