//
//  ProductDetailInfoView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 12/08/2021.
//

import SwiftUI
import Combine

struct ProductDetailInfoView: View {
    private let viewModel: ProductDetailViewModel

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.name)
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
                Text(viewModel.price)
                    .font(.title2)
            }
            Text(viewModel.description)
        }.padding(.all)
    }
}

struct ProductDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailInfoView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}

private extension ProductDetailInfoView_Previews {
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
                               adidasAPI: ProductDetailInfoView_Previews.MockAdidasAPI(reviews: []),
                               onReviewSubmitted: {})
        }
    }
    
    static let product = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description",
        currency: "$",
        price: 160,
        imgUrl: ""
    )
    static let viewModel = makeViewModel(with: product)
}

private extension ProductDetailInfoView_Previews {
    static func makeViewModel(with product: Product) -> ProductDetailViewModel {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader,
                                      adidasAPI: MockAdidasAPI(reviews: []),
                                      factory: MockFactory())
    }
}
