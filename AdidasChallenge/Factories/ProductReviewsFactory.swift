//
//  ProductReviewsFactory.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 16/08/2021.
//

protocol ProductReviewsFactory {
    func makeProductReviewsViewModel(for product: Product,
                                     with reviews: ProductReviews,
                                     onReviewSubmitted: @escaping () -> Void) -> ProductReviewsViewModel
    func makeAddReviewViewModel(for product: Product, onReviewSubmitted: @escaping () -> Void) -> AddReviewViewModel
}
