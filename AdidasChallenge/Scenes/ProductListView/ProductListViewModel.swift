//
//  ProductListViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Combine
import Foundation

class ProductListViewModel: ObservableObject {
    // MARK: Private Properties

    private let adidasAPI: AdidasAPIProductsProtocol
    private let factory: ProductCellFactory & ProductDetailFactory

    private var products: Products = []
    private lazy var filteredProducts = products

    private let noProductsText = "There is no products on our shop yet."
    private let noFilteredProductsText = "There is no products for that search. \nTry another word."

    private var subscriptions: Set<AnyCancellable> = .init()

    // MARK: Lifecycle

    init(adidasAPI: AdidasAPIProductsProtocol,
         factory: ProductCellFactory & ProductDetailFactory) {
        self.adidasAPI = adidasAPI
        self.factory = factory
        updateFilteredProducts()
    }

    // MARK: Public Properties

    @Published var models: [ProductListModel] = []
    let navigationTitle = "Search"
    private(set) lazy var noProductsMessage: String? = products.isEmpty ? noProductsText : nil

    // MARK: Public Methods

    func viewDidAppear() {
        adidasAPI
            .getProducts()
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { [weak self] response in
                self?.products = response
                self?.resetFilteredProducts()
            }).store(in: &subscriptions)
    }

    func searchProduct(for searchText: String) {
        if searchText.isEmpty {
            resetFilteredProducts()
        } else {
            filteredProducts = products
                .filter { product in
                    product.search(on: [\.name, \.description], for: searchText)
                }
            if filteredProducts.isEmpty {
                noProductsMessage = noFilteredProductsText
            }
            updateFilteredProducts()
        }
    }

    // MARK: Private Methods

    private func productCellViewModel(for product: Product) -> ProductCellViewModelProtocol {
        factory.makeProductCellViewModel(for: product)
    }

    private func productDetailViewModel(for product: Product) -> ProductDetailViewModel {
        factory.makeProductDetailViewModel(for: product)
    }

    private func updateFilteredProducts() {
        models = filteredProducts
            .map { product in
                ProductListModel(id: product.id,
                                 cellViewModelProtocol: productCellViewModel(for: product),
                                 detailViewModel: productDetailViewModel(for: product))
            }
    }

    private func resetFilteredProducts() {
        filteredProducts = products
        noProductsMessage = products.isEmpty ? noProductsText : nil
        updateFilteredProducts()
    }
}

// MARK: Product search extension

private extension Product {
    func search(on paths: [KeyPath<Product, String>], for searchText: String) -> Bool {
        paths.contains { path in
            self[keyPath: path].range(of: searchText, options: .caseInsensitive) != nil
        }
    }
}
