//
//  HomeViewModel.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//  
//

class HomeViewModel: ViewModelBase, HomeViewModelProtocol {
	private let apiClient: APIClient
	private let router: HomeRouterProtocol

	required init(router: HomeRouterProtocol, apiClient: APIClient) {
		self.router = router
		self.apiClient = apiClient
		super.init()
	}
}
