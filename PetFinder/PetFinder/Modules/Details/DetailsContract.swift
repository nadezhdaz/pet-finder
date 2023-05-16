//
//  DetailsContract.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import UIKit

protocol DetailsViewModelProtocol: ViewModelProtocolBase, ObservableObject {
    func onAppear()
}

protocol DetailsAssemblyProtocol: Assembly {}

protocol DetailsRouterProtocol: RouterProtocolBase {}
