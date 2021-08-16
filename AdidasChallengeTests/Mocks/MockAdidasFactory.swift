//
//  MockAdidasFactory.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation
@testable import AdidasChallenge

class MockAdidasFactory: ProductCellFactory, ProductDetailFactory, ProductReviewsFactory {
    var productCellViewModel: ProductCellViewModel! = nil
    private(set) var isMakeProductCellViewModelCalled = false
    
    var productDetailViewModel: ProductDetailViewModel! = nil
    private(set) var isMakeProductDetailViewModelCalled = false
    
    var productReviewsViewModel: ProductReviewsViewModel! = nil
    private(set) var isMakeProductReviewsViewModelCalled = false
    
    var addReviewViewModel: AddReviewViewModel! = nil
    private(set) var isMakeAddReviewViewModelCalled = false
    
    func makeProductCellViewModel(for product: Product) -> ProductCellViewModelProtocol {
        isMakeProductCellViewModelCalled = true
        return productCellViewModel
    }

    func makeProductDetailViewModel(for product: Product) -> ProductDetailViewModel {
        isMakeProductDetailViewModelCalled = true
        return productDetailViewModel
    }

    func makeProductReviewsViewModel(for product: Product, with reviews: ProductReviews, onReviewSubmitted: @escaping () -> Void) -> ProductReviewsViewModel {
        isMakeProductReviewsViewModelCalled = true
        return productReviewsViewModel
    }

    func makeAddReviewViewModel(for product: Product, onReviewSubmitted: @escaping () -> Void) -> AddReviewViewModel {
        isMakeAddReviewViewModelCalled = true
        return addReviewViewModel
    }
}
