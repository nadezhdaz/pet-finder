//
//  Animal.swift
//  PetFinder
//
//  Created by Nadezhda Zenkova on 18.05.2023.
//

import Foundation

public struct Animal: Identifiable, Codable {
    public let id: Int
    public let url: URL?
    public let type: String
    public let species: String
    public let age: String?
    public let gender: String
    public let size: String?
    public let coat: String?
    public let name: String?
    public let description: String?
    public let status: String?
    public let tags: [String]
    public let distance: Double?
}
