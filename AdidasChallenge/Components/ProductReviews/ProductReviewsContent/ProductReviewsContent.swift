//
//  ProductReviewsContent.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 13/08/2021.
//

import SwiftUI

struct ProductReviewsContent: View {
    private let viewModel: ProductReviewsViewModelProtocol

    init(viewModel: ProductReviewsViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.ratingsCountValue == 0 {
            Text(viewModel.noReviewsMessage)
                .padding(.all, 15)
        } else {
            List(viewModel.indices) { index in
                let viewModel = viewModel.productReviewCellViewModel(for: index)
                ProductReviewCell(viewModel: viewModel)
            }
            // SwiftUI weird separators not aligned
            .padding(.leading, -16)
        }
    }
}

struct ProductReviewsContent_Previews: PreviewProvider {
    private static let viewModel = ProductReviewsViewModel(reviews: [
        makeReview(rating: 0, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        makeReview(rating: 2, text: "dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic "),
        makeReview(rating: 7, text: "typesetting, remaining essentially unchanged.")
    ])
    static func makeReview(rating: Int, text: String) -> ProductReview {
        ProductReview(productId: "HI333", locale: "en-us", rating: rating, text: text)
    }

    static var previews: some View {
        ProductReviewsContent(viewModel: viewModel)
            .previewLayout(.sizeThatFits)

        ProductReviewsContent(viewModel: ProductReviewsViewModel(reviews: []))
            .previewLayout(.sizeThatFits)
    }
}
