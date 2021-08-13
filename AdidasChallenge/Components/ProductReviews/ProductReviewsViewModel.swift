//
//  ProductReviewsViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

class ProductReviewsViewModel: ProductReviewsViewModelProtocol {
    private let reviews: ProductReviews
    
    init(reviews: ProductReviews) {
        self.reviews = reviews
    }
    
    private(set) lazy var indices: Range<Int> = reviews.indices
    
    func productReviewCellViewModel(for index: Int) -> ProductReviewCellViewModelProtocol {
        let review = reviews[index]
        return ProductReviewCellViewModel(review: review)
    }
}
