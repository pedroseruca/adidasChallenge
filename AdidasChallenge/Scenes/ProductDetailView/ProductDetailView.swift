//
//  ProductDetailView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Combine
import SwiftUI

struct ProductDetailView: View {
    // MARK: Inner types
    
    private typealias Style = Constants.Style.ProductDetailView
    
    // MARK: Private Properties

    @ObservedObject private var viewModel: ProductDetailViewModel

    // MARK: Lifecycle

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public Properties

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width

            VStack {
                AsyncImage(viewModel: viewModel.imageViewModel(for: Float(width))) {
                    ProgressView()
                        .padding(.bottom, Style.progressViewPadding)
                        .frame(width: width, height: width)
                        .scaleEffect(Style.progressViewScale)
                } image: { image in
                    Image(uiImage: image)
                        .frame(width: width, height: width)

                } error: { _ in
                    Image(Style.noImageAsset)
                        .resizable()
                        .frame(width: Style.noImageSize, height: Style.noImageSize)
                        .padding(.top, geometry.safeAreaInsets.top)
                }

                ProductDetailInfoView(viewModel: viewModel)
                Divider()
                if let reviewsViewModel = viewModel.reviewsViewModel {
                    ProductReviewsView(viewModel: reviewsViewModel)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            viewModel.viewDidAppear()
        }
    }
}

// MARK: SwiftUI Previews

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: viewModel)

        ProductDetailView(viewModel: viewModelNoImage)

        ProductDetailView(viewModel: viewModelLoading)
    }
}

private extension ProductDetailView_Previews {
    static let product = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description",
        currency: "$",
        price: 160,
        imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/807d251c686648de85f2abb10042fdf9_9366/GC7240_01_laydown.jpg"
    )
    static let product2 = Product(
        id: "HI333",
        name: "Sapatos Forum 84 BB",
        description: "Description Description",
        currency: "$",
        price: 160,
        imgUrl: ""
    )
    private static let viewModel = makeViewModel(with: product)
    private static let viewModelNoImage = makeViewModel(with: product2)
    private static let viewModelLoading = makeViewModelLoading()
}

private extension ProductDetailView_Previews {
    class MockImageLoader: ImageLoaderProtocol {
        var statePublisher: Published<ImageLoaderState>.Publisher { $state }

        @Published private var state: ImageLoaderState = .initial

        func load(with imageWidth: Int?) {
        }
    }

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
                               adidasAPI: ProductDetailView_Previews.MockAdidasAPI(reviews: []),
                               onReviewSubmitted: {})
        }
    }

    static func makeViewModelLoading() -> ProductDetailViewModel {
        let imageLoader = MockImageLoader()
        return ProductDetailViewModel(
            product: product,
            imageLoader: imageLoader,
            adidasAPI: ProductDetailView_Previews.MockAdidasAPI(reviews: []),
            factory: MockFactory())
    }

    static func makeViewModel(with product: Product) -> ProductDetailViewModel {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(
            product: product,
            imageLoader: imageLoader,
            adidasAPI: MockAdidasAPI(reviews: []),
            factory: MockFactory())
    }
}
