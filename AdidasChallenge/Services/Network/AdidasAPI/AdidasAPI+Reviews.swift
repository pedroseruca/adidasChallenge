//
//  AdidasAPI+Reviews.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Combine
import Foundation

protocol AdidasAPIReviewsProtocol {
    func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error>
    func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error>
}

extension AdidasAPI: AdidasAPIReviewsProtocol {
    func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error> {
        let endpoint = Endpoint(port: 3002,
                                path: .reviews(productId: productId),
                                method: .get)
        guard let request = endpoint.request else { return noUrlRequestPublisher() }

        return serviceManager.execute(request: request,
                                      decodingType: ProductReviews.self,
                                      receiveOn: .main)
    }

    func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error> {
        guard let data = try? JSONEncoder().encode(review) else { return couldntEncodeObjectPublisher() }

        let endpoint = Endpoint(port: 3002,
                                path: .reviews(productId: productId),
                                method: .post(data))
        guard let request = endpoint.request else { return noUrlRequestPublisher() }

        return serviceManager.execute(request: request,
                                      receiveOn: .main)
    }
}
