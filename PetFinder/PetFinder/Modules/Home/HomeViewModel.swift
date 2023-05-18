//
//  HomeViewModel.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import Combine

final class HomeViewModel: HomeViewModelProtocol {
    // MARK: - PRIVATE PROPERTIES

    @Published var postalCode: String? = "T0J 0A0"
    private var cancellables: Set<AnyCancellable> = .init()
    private let apiClient: PetFinderApiClientProtocol
    @Published var location: String = ""

    // MARK: - VIEW MODEL PROPERTIES

    var greeting: String = "Hey Buddy, Adopt a new friend near you!"
    @Published var lightBulb: String = "style.on"
    @Published var pets: [Animal] = []

    // MARK: - INITIALIZATION

    init(apiClient: PetFinderApiClientProtocol) {
        self.apiClient = apiClient

        setupBindings()
    }

    // MARK: - VIEW MODEL METHODS

    func resetColorScheme() {

    }

    func onAppear() {
        getClosestAnimals(forLocation: location)
    }

    // MARK: - CONFIGURATION

    private func setupBindings() {
        $postalCode.compactMap { $0 }
            .assign(to: &$location)
    }

    private func getClosestAnimals(forLocation location: String) -> Future<[Animal], PetNetworkError> {
        return Future() { [weak self] promise in
            guard let self = self else { return }
            self.apiClient.getAnimals(forLocation: location)
                .sink { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        self?.handleError(error)
                    case .finished: break
                    }
                } receiveValue: { [weak self] animals in
                    self?.pets = animals
                }
                .store(in: &self.cancellables)
        }
    }

    // MARK: - PRIVATE METHODS

    private func handleError(_ error: PetNetworkError) {

    }

}

// MARK: - LOCALIZATION

private extension String {

}
