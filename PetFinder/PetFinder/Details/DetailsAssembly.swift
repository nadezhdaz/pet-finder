//
//  DetailsAssembly.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//  
//

import UIKit

struct DetailsAssembly {
    func assembly() -> UIViewController {
        let router = DetailsRouter()
        guard let apiClient = APIClient.current else {
            Log.write(message: "apiclient should be initialized", category: .assembly , level: .error)
            return UIViewController()
        }
        let viewModel = DetailsViewModel(router: router, apiClient: apiClient)
        let viewController = DetailsViewController(viewModel)
        router.currentViewController = viewController
        return viewController
    }
}
