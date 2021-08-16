//
//  ProductReviewsViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

class ProductReviewsViewModel: ProductReviewsViewModelProtocol {
    private let product: Product
    private let reviews: ProductReviews
    private let factory: ProductReviewsFactory
    private let onReviewSubmitted: () -> Void

    private lazy var averageRatingValue: Double = {
        let ratingsSummedUp = reviews
            .map { $0.rating }
            .reduce(0, +)
        return Double(ratingsSummedUp) / Double(ratingsCountValue)
    }()

    init(product: Product,
         reviews: ProductReviews,
         factory: ProductReviewsFactory,
         onReviewSubmitted: @escaping () -> Void) {
        self.product = product
        self.reviews = reviews
        self.factory = factory
        self.onReviewSubmitted = onReviewSubmitted
    }

    let addReviewButtonTitle = "Add review"
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

    var addReviewViewModel: AddReviewViewModel {
        factory.makeAddReviewViewModel(for: product,
                                       onReviewSubmitted: onReviewSubmitted)
    }
}
