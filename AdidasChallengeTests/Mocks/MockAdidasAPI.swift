//
//  MockAdidasAPI.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation
import Combine
@testable import AdidasChallenge

class MockAdidasAPI: AdidasAPIProductsProtocol, AdidasAPIReviewsProtocol {
    var getProductsResult: Result<Products, Error>! = nil
    private(set) var isGetProductsCalled = false
    
    var getReviewsResult: Result<ProductReviews, Error>! = nil
    private(set) var isGetReviewCalled = false
    
    var postReviewResult: Result<Void, Error>! = nil
    private(set) var isPostReviewCalled = false

    func getProducts() -> AnyPublisher<Products, Error> {
        isGetProductsCalled = true
        return Future { $0(self.getProductsResult) }
            .eraseToAnyPublisher()
    }

    func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error> {
        isGetReviewCalled = true
        return Future { $0(self.getReviewsResult) }
            .eraseToAnyPublisher()
    }

    func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error> {
        isPostReviewCalled = true
        return Future { $0(self.postReviewResult) }
            .eraseToAnyPublisher()
    }
}
