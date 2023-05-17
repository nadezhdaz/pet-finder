//
//  Animal.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 18.05.2023.
//

import Foundation

public struct Animal: Codable {
    let id: Int
    let url: URL?
    let type: String
    let species: String
    let age: String?
    let gender: String
    let size: String?
    let coat: String?
    let name: String?
    let description: String?
    let status: String?
    let tags: [String]
    let distance: Double?
}
