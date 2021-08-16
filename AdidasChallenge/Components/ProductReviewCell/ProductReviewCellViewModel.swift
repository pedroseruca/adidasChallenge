//
//  ProductReviewCellViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import Foundation

class ProductReviewCellViewModel: ProductReviewCellViewModelProtocol {
    // MARK: Private Properties

    private let review: ProductReview

    // MARK: Lifecycle

    init(review: ProductReview) {
        self.review = review
    }

    // MARK: Public Properties

    let id = UUID()
    private(set) lazy var rating = "\(review.rating)"
    private(set) lazy var text = review.text
}
