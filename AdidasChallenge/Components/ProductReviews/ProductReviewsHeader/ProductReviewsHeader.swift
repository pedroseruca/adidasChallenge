//
//  ProductReviewsHeader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 13/08/2021.
//

import Combine
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

struct ProductReviewsHeader_Previews: PreviewProvider {
    struct MockAdidasAPI: AdidasAPIReviewsProtocol {
        let reviews: ProductReviews
        func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error> {
            Future { $0(.success(reviews)) }
                .eraseToAnyPublisher()
        }

        func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error> {
            Future { $0(.success(())) }
                .eraseToAnyPublisher()
        }
    }

    struct MockFactory: ProductReviewsFactory {
        func makeProductReviewsViewModel(for product: Product, with reviews: ProductReviews, onReviewSubmitted: @escaping () -> Void) -> ProductReviewsViewModel {
            ProductReviewsViewModel(product: product,
                                    reviews: reviews,
                                    factory: self,
                                    onReviewSubmitted: { })
        }

        func makeAddReviewViewModel(for product: Product, onReviewSubmitted: @escaping () -> Void) -> AddReviewViewModel {
            AddReviewViewModel(product: product,
                               adidasAPI: ProductReviewsHeader_Previews.MockAdidasAPI(reviews: []),
                               onReviewSubmitted: {})
        }
    }

    private static let reviews = [
        makeReview(rating: 0, text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"),
        makeReview(rating: 2, text: "dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic "),
        makeReview(rating: 7, text: "typesetting, remaining essentially unchanged."),
        makeReview(rating: 10, text: "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing "),
        makeReview(rating: 0, text: "test"),
        makeReview(rating: 2, text: "test 2"),
        makeReview(rating: 7, text: "test 3"),
        makeReview(rating: 10, text: "test 4"),
    ]
    private static let product = Product(
        id: "HI333",
        name: "product",
        description: "description",
        currency: "$",
        price: 4,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
    )
    private static let viewModel = ProductReviewsViewModel(
        product: product,
        reviews: reviews,
        factory: MockFactory(),
        onReviewSubmitted: {})
    static func makeReview(rating: Int, text: String) -> ProductReview {
        ProductReview(productId: "HI333", locale: "en-us", rating: rating, text: text)
    }

    static var previews: some View {
        ProductReviewsHeader(viewModel: viewModel)
            .previewLayout(.sizeThatFits)

        ProductReviewsHeader(viewModel: ProductReviewsViewModel(
            product: product,
            reviews: [],
            factory: MockFactory(),
            onReviewSubmitted: {}))
            .previewLayout(.sizeThatFits)
    }
}
