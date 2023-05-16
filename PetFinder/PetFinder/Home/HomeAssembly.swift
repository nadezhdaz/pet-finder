//
//  HomeAssembly.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import SwiftUI

struct HomeAssembly {
    func assembly() -> UIViewController {
        let router = HomeRouter()

        let apiClient = HTTPClientsFactory.make()
        let viewModel = HomeViewModel(router: router, apiClient: apiClient)
        let view = HomeView(with: viewModel)
        let vc = HostingControllerBase(rootView: view, viewModel: viewModel)
        router.currentViewController = vc
        return vc
    }
}
