//
//  ProductReviewsViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

class ProductReviewsViewModel: ProductReviewsViewModelProtocol {
    private let reviews: ProductReviews

    private lazy var averageRatingValue: Double = {
        let ratingsSummedUp = reviews
            .map { $0.rating }
            .reduce(0, +)
        return Double(ratingsSummedUp) / Double(ratingsCountValue)
    }()

    init(reviews: ProductReviews) {
        self.reviews = reviews
    }
    private(set) lazy var indices: Range<Int> = reviews.indices
    private(set) lazy var ratingsCountValue = reviews.count
    private lazy var valuationsString = ratingsCountValue > 1 ? "valuations" : "valuation"
    private(set) lazy var ratingsCount = "of \(ratingsCountValue) " + valuationsString
    private(set) lazy var averageRating = String(format: "%.1f ", averageRatingValue)
    
    private(set) lazy var noReviewsMessage = "No reviews for this product yet. Be the first to leave one"

    func productReviewCellViewModel(for index: Int) -> ProductReviewCellViewModelProtocol {
        let review = reviews[index]
        return ProductReviewCellViewModel(review: review)
    }
}
