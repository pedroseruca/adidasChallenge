//
//  ProductReviewCellViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import Foundation

class ProductReviewCellViewModel: ProductReviewCellViewModelProtocol {
    private let review: ProductReview
    let id = UUID()
    
    init(review: ProductReview) {
        self.review = review
    }
    
    private(set) lazy var rating = "\(review.rating)"
    private(set) lazy var text = review.text
}
