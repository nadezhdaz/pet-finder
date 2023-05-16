//
//  HomeAssembly.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//  
//

import UIKit

struct HomeAssembly {
    func assembly() -> UIViewController {
        let router = HomeRouter()
        guard let apiClient = APIClient.current else {
            Log.write(message: "apiclient should be initialized", category: .assembly , level: .error)
            return UIViewController()
        }
        let viewModel = HomeViewModel(router: router, apiClient: apiClient)
        let viewController = HomeViewController(viewModel)
        router.currentViewController = viewController
        return viewController
    }
}
