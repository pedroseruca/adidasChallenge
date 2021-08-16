//
//  ProductReview.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 09/08/2021.
//

// MARK: - ProductReview

struct ProductReview: Codable {
    let productId: String
    let locale: String
    let rating: Int
    let text: String

    private enum CodingKeys: String, CodingKey {
        case productId
        case locale
        case rating
        case text
    }
}

typealias ProductReviews = [ProductReview]
