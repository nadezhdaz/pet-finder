//
//  HomeContract.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 16.05.2023.
//

import UIKit

protocol HomeViewModelProtocol: ObservableObject {
    var greeting: String { get }
    var lightBulb: String { get }
    var pets: [Animal] { get }

    func onAppear()
    func resetColorScheme()
}

protocol HomeAssemblyProtocol {}

protocol HomeRouterProtocol {}
