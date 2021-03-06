//
//  InitialView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 09/08/2021.
//

import Combine
import SwiftUI

struct ProductListView: View {
    // MARK: Private Properties

    @ObservedObject private var viewModel: ProductListViewModel

    // MARK: Lifecycle

    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Public Properties

    var body: some View {
        NavigationView {
            VStack {
                SearchBar { searchText in
                    viewModel.searchProduct(for: searchText)
                }
                .padding(.horizontal)

                if viewModel.showNoProductsMessage {
                    Text(viewModel.noProductsMessage)
                }

                if let models = viewModel.models {
                    ScrollView {
                        LazyVStack {
                            ForEach(models) { model in
                                let detailView = ProductDetailView(viewModel: model.detailViewModel)
                                NavigationLink(destination: detailView) {
                                    ProductCell(viewModel: model.cellViewModelProtocol)

                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }.resignKeyboardOnDragGesture()
                } else {
                    ProgressView()
                        .padding()
                        .scaleEffect(Constants.Style.ProductListView.progressViewScale)
                }
                Spacer()
            }
            .navigationBarTitle(Text(viewModel.navigationTitle))
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Opps!!"),
                      message: Text("There's been an error while requesting information."),
                      primaryButton: .default(
                          Text("Try again"),
                          action: {
                              viewModel.retryAlertButtonPressed()
                          }),
                      secondaryButton: .default(Text("Cancel")))
            }
        }.onAppear {
            viewModel.viewDidAppear()
        }
    }
}

// MARK: SwiftUI Previews

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: viewModel)

        ProductListView(viewModel: viewModelNoProducts)
    }
}

private extension InitialView_Previews {
    struct MockAdidasAPI: AdidasAPIProductsProtocol, AdidasAPIReviewsProtocol {
        let products: Products

        func getProducts() -> AnyPublisher<Products, Error> {
            Future { $0(.success(products)) }
                .eraseToAnyPublisher()
        }

        func getReview(for productId: String) -> AnyPublisher<ProductReviews, Error> {
            Future { $0(.success([])) }
                .eraseToAnyPublisher()
        }

        func postReview(for productId: String, review: ProductReview) -> AnyPublisher<Void, Error> {
            Future { $0(.success(())) }
                .eraseToAnyPublisher()
        }
    }

    struct MockAdidasFactory: ProductCellFactory, ProductDetailFactory, ProductReviewsFactory {
        func makeProductCellViewModel(for product: Product) -> ProductCellViewModelProtocol {
            let imageLoader = ImageLoader(for: product.imgUrl)
            return ProductCellViewModel(product: product,
                                        imageLoader: imageLoader)
        }

        func makeProductDetailViewModel(for product: Product) -> ProductDetailViewModel {
            let imageLoader = ImageLoader(for: product.imgUrl)
            return ProductDetailViewModel(
                product: product,
                imageLoader: imageLoader,
                adidasAPI: InitialView_Previews.MockAdidasAPI(products: []),
                factory: self)
        }

        func makeProductReviewsViewModel(for product: Product, with reviews: ProductReviews, onReviewSubmitted: @escaping () -> Void) -> ProductReviewsViewModel {
            ProductReviewsViewModel(product: product,
                                    reviews: [],
                                    factory: self,
                                    onReviewSubmitted: {})
        }

        func makeAddReviewViewModel(for product: Product, onReviewSubmitted: @escaping () -> Void) -> AddReviewViewModel {
            AddReviewViewModel(product: product,
                               adidasAPI: InitialView_Previews.MockAdidasAPI(products: []),
                               onReviewSubmitted: {})
        }
    }

    private static let viewModelNoProducts = ProductListViewModel(adidasAPI: mockAdidasAPINoProducts, factory: MockAdidasFactory())
    private static let mockAdidasAPINoProducts = MockAdidasAPI(products: [])
    private static let viewModel = ProductListViewModel(adidasAPI: mockAdidasAPI, factory: MockAdidasFactory())
    private static let mockAdidasAPI = MockAdidasAPI(products: mockProducts)
    private static let mockProducts = [
        Product(
            id: "HI333",
            name: "product",
            description: "description",
            currency: "$",
            price: 4,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c7099422ccc14e44b406abec00ba6c96_9366/NMD_R1_V2_Shoes_Black_FY6862_01_standard.jpg"
        ),
        Product(
            id: "HI334",
            name: "product",
            description: "description",
            currency: "$",
            price: 87,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/c93fa315d2f64775ac1fab96016f09d1_9366/Dame_6_Shoes_Black_FV8624_01_standard.jpg"
        ),
        Product(
            id: "HI336",
            name: "product",
            description: "description",
            currency: "$",
            price: 36,
            imgUrl: "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/3eebc0498b1347e397f8ab94016140ba_9366/FS1496_00_plp_standard.jpg"
        ),
    ]
}
