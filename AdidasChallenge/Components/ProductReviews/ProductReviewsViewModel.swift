//
//  ProductReviewsViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

class ProductReviewsViewModel: ProductReviewsViewModelProtocol {
    let reviews: ProductReviews
    
    init(reviews: ProductReviews) {
        self.reviews = reviews
    }
}
