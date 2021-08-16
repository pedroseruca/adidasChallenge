//
//  Product.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 09/08/2021.
//

// MARK: - Product

struct Product: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let currency: String
    let price: Int
    let imgUrl: String
}

typealias Products = [Product]
