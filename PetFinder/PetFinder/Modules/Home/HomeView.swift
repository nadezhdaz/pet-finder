//
//  HomeView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI
import Combine

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                    Text(viewModel.greeting)
                        .font(.header1.mediumEmphasis)
                        .padding(.top, Semantic.dimension.spacing.large)
                        .padding(.bottom, Semantic.dimension.spacing.small)
                        .padding(.horizontal, Semantic.dimension.spacing.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Button(action: {
                            viewModel.resetColorScheme()
                        }) {
                            Image(viewModel.lightBulb)
                                .foregroundColor(Semantic.Rebranding.color.basic.onBg.secondary.value.color)
                                .frame(minWidth: 0, maxWidth: .none, alignment: .leading)
                                .padding(.leading, Semantic.dimension.spacing.small)
                        }
                    }
                    .background(Semantic.Rebranding.color.basic.bg.foreground.value.color)
                    // .clipRoundCorners()
                    .padding(.horizontal, Semantic.dimension.spacing.medium)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.goToSearchScreen()
                    }
                    ForEach(viewModel.pets) { pet in
                        PetCardView(viewModel: viewModel)
                    }
                    .padding(.horizontal, Semantic.dimension.spacing.medium)
                }
                .padding(.bottom, Semantic.dimension.spacing.small)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: viewModel.onAppear)
                .transaction { transaction in
                    transaction.animation = nil
                }
            }
            .background(Semantic.Rebranding.color.basic.bg.primary)
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

