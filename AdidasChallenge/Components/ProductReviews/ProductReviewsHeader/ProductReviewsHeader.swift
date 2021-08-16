//
//  ProductReviewsHeader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 13/08/2021.
//

import SwiftUI

struct ProductReviewsHeader: View {
    private let viewModel: ProductReviewsViewModelProtocol

    init(viewModel: ProductReviewsViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 0) {
            Text("Reviews")
                .font(.title2)
                .fontWeight(.medium)
            Spacer()
            if viewModel.ratingsCountValue != 0 {
                Text(viewModel.averageRating)
                    .font(.title3)
                    .fontWeight(.medium)
                Text(viewModel.ratingsCount)
            }
        }
    }
}
//
//struct ProductReviewsHeader_Previews: PreviewProvider {
//    private static let viewModel = ProductReviewsViewModel(reviews: [
//        makeReview(rating: 0),
//        makeReview(rating: 2),
//        makeReview(rating: 7),
//        makeReview(rating: 10),
//        makeReview(rating: 0),
//        makeReview(rating: 2),
//        makeReview(rating: 7),
//        makeReview(rating: 10),
//    ])
//    static func makeReview(rating: Int) -> ProductReview {
//        ProductReview(productId: "HI333", locale: "en-us", rating: rating, text: "test")
//    }
//
//    static var previews: some View {
//        ProductReviewsHeader(viewModel: viewModel)
//            .previewLayout(.sizeThatFits)
//
//        ProductReviewsHeader(viewModel: ProductReviewsViewModel(reviews: []))
//            .previewLayout(.sizeThatFits)
//    }
//}
