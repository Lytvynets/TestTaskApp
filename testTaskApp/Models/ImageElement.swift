//
//  ImageElement.swift
//  testTaskApp
//
//  Created by Vlad Lytvynets on 12.10.2021.
//

import Foundation

// MARK: - ImageElement
struct ImageElement: Codable {
    let id, author: String
    let width, height: Int
    let url, downloadURL: String

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias Image3 = [ImageElement]
