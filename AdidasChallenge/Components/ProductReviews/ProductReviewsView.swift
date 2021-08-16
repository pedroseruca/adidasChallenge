//
//  ProductReviewsView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI

struct ProductReviewsView: View {
    private let viewModel: ProductReviewsViewModelProtocol

    init(viewModel: ProductReviewsViewModelProtocol) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            ProductReviewsHeader(viewModel: viewModel)
                .padding(.horizontal, 15)
            ProductReviewsContent(viewModel: viewModel)
            HStack {
                Spacer()
                NavigationLink(destination:
                    AddReviewView(viewModel: viewModel.addReviewViewModel)
                ) {
                    Text(viewModel.addReviewButtonTitle)
                }
                .padding()
                .buttonStyle(PrimaryButtonStyle(color: .black))
            }
        }
    }
}

struct ProductReviewsView_Previews: PreviewProvider {
    private static let viewModel = ProductReviewsViewModel(reviews: [
        makeReview(rating: 0, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        makeReview(rating: 2, text: "dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic "),
        makeReview(rating: 7, text: "typesetting, remaining essentially unchanged."),
        makeReview(rating: 10, text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing "),
        makeReview(rating: 0, text: "test"),
        makeReview(rating: 2, text: "test 2"),
        makeReview(rating: 7, text: "test 3"),
        makeReview(rating: 10, text: "test 4"),
    ])
    static func makeReview(rating: Int, text: String) -> ProductReview {
        ProductReview(productId: "HI333", locale: "en-us", rating: rating, text: text)
    }

    static var previews: some View {
        ProductReviewsView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)

        ProductReviewsView(viewModel: ProductReviewsViewModel(reviews: []))
            .previewLayout(.sizeThatFits)
    }
}
