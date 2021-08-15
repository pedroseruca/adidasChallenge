//
//  AdidasAPIProviderProtocol.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Combine

protocol AdidasAPIProtocol {
    func getProducts() -> AnyPublisher<Products, Error>
    func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error>
    func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error>
}
