//
//  MockProductReviews.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

@testable import AdidasChallenge

enum MockProductReviews {
    static let `default` = [
        makeReview(rating: 0, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        makeReview(rating: 2, text: "dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic "),
        makeReview(rating: 7, text: "typesetting, remaining essentially unchanged."),
        makeReview(rating: 10, text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing "),
        makeReview(rating: 0, text: "test"),
        makeReview(rating: 2, text: "test 2"),
        makeReview(rating: 7, text: "test 3"),
        makeReview(rating: 10, text: "test 4"),
    ]
    static let empty: ProductReviews = []
    
    private static func makeReview(rating: Int, text: String) -> ProductReview {
        ProductReview(productId: "HI333", locale: "en-us", rating: rating, text: text)
    }
}
