//
//  DetailsAssembly.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI

struct DetailsAssembly {
    func assembly() -> UIViewController {
        let router = DetailsRouter()

        let apiClient = HTTPClientsFactory.make()
        let viewModel = DetailsViewModel(router: router, apiClient: apiClient)
        let view = DetailsView(with: viewModel)
        let vc = HostingControllerBase(rootView: view, viewModel: viewModel)
        router.currentViewController = vc
        return vc
    }
}
