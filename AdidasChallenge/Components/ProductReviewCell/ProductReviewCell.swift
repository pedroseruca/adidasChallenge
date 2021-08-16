//
//  ProductReviewCell.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductReviewCell: View {
    // MARK: Private Properties

    private let viewModel: ProductReviewCellViewModelProtocol

    // MARK: Lifecycle

    init(viewModel: ProductReviewCellViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: Public Properties

    var body: some View {
        HStack {
            Text("\(viewModel.rating)")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.gray)
                .frame(minWidth: Constants.Style.ProductReviewCell.minWidth)
            Text(viewModel.text)
        }
    }
}

// MARK: SwiftUI Previews

struct ProductReviewCell_Previews: PreviewProvider {
    private static let review = ProductReview(productId: "HI333", locale: "en-us", rating: 8, text: "typesetting, remaining essentially unchanged.")
    private static let viewModel = ProductReviewCellViewModel(review: review)
    static var previews: some View {
        ProductReviewCell(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
