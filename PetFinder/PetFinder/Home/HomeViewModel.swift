//
//  HomeViewModel.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import Combine

final class HomeViewModel: ViewModelBase, HomeViewModelProtocol {
    // MARK: - PRIVATE PROPERTIES

    private var cancellables: Set<AnyCancellable> = .init()
    private let router: HomeRouterProtocol
    private let apiClient: APIClient

    // MARK: - VIEW MODEL PROPERTIES

    // MARK: - INITIALIZATION

    init(router: HomeRouterProtocol, apiClient: APIClient) {
        self.router = router
        self.apiClient = apiClient

        super.init()

        setupBindings()
    }

    // MARK: - VIEW MODEL METHODS

    func onAppear() {

    }

    // MARK: - CONFIGURATION

    private func setupBindings() {

    }

    // MARK: - PRIVATE METHODS
}

// MARK: - LOCALIZATION

private extension String {

}
