//
//  DetailsView.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI
import Combine

struct DetailsView<ViewModel: DetailsViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {

        }
        .background(Color.white)
        .navigationTitle(String.title)
        .onAppear(perform: viewModel.onAppear)
    }
}

// MARK: - LOCALIZATION

private extension String {
    /// title
    static let title = "title"
}
