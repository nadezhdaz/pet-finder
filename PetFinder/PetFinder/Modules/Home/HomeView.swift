//
//  HomeView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI
import Combine

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel: HomeViewModel

    init(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                    Text(viewModel.greeting)
                            .font(.title)
                        .padding(.top, 4)
                        .padding(.bottom, 30)
                        .padding(.leading, 20)
                        .frame(width: 150)

                        Button(action: {
                            viewModel.resetColorScheme()
                        }) {
                            Image(viewModel.lightBulb)
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                    }
                    ForEach(viewModel.pets) { pet in
                        PetCardView(viewModel: viewModel)
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: viewModel.onAppear)
                .transaction { transaction in
                    transaction.animation = nil
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// MARK: - LOCALIZATION

private extension String {
    /// Услуги
    static let title = "Nearby results"
    static let magnifyingGlass = "magnifyingglass"
}

