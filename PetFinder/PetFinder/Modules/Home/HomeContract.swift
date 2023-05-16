//
//  HomeContract.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import UIKit

protocol HomeViewModelProtocol: ViewModelProtocolBase, ObservableObject {
    func onAppear()
}

protocol HomeAssemblyProtocol: Assembly {}

protocol HomeRouterProtocol: RouterProtocolBase {}
