//
//  DetailsViewModel.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//  
//

class DetailsViewModel: ViewModelBase, DetailsViewModelProtocol {
	private let apiClient: APIClient
	private let router: DetailsRouterProtocol

	required init(router: DetailsRouterProtocol, apiClient: APIClient) {
		self.router = router
		self.apiClient = apiClient
		super.init()
	}
}
