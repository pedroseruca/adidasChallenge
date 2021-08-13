//
//  ProductReviewCell.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductReviewCell: View {
    private let viewModel: ProductReviewCellViewModelProtocol

    init(viewModel: ProductReviewCellViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProductReviewCell_Previews: PreviewProvider {
    private static let review = ProductReview(productId: "HI333", locale: "en-us", rating: 0, text: "test")
    private static let viewModel = ProductReviewCellViewModel(review: review)
    static var previews: some View {
        ProductReviewCell(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
