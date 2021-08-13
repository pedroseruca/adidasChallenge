//
//  ProductReviewCellViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

class ProductReviewCellViewModel: ProductReviewCellViewModelProtocol {
    private let review: ProductReview
    
    init(review: ProductReview) {
        self.review = review
    }
    
    private(set) lazy var rating = "\(review.rating)"
    private(set) lazy var text = review.text
}
