//
//  ProductListViewModel.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 11/08/2021.
//

import Combine
import Foundation

class ProductListViewModel: ObservableObject {
    private let adidasAPI: AdidasAPIProductsProtocol

    private var products: Products = []
    private lazy var filteredProducts = products

    private let noProductsText = "There is no products on our shop yet."
    private let noFilteredProductsText = "There is no products for that search. \nTry another word."

    init(adidasAPI: AdidasAPIProductsProtocol) {
        self.adidasAPI = adidasAPI
        updateFilteredProducts()
    }

    @Published var models: [ProductListModel] = []
    let navigationTitle = "Search"
    private(set) lazy var noProductsMessage: String? = products.isEmpty ? noProductsText : nil
    private var subscriptions: Set<AnyCancellable> = .init()

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

    private func productCellViewModel(for product: Product) -> ProductCellViewModelProtocol {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductCellViewModel(product: product,
                                    imageLoader: imageLoader)
    }

    private func productDetailViewModel(for product: Product) -> ProductDetailViewModelProtocol {
        let imageLoader = ImageLoader(for: product.imgUrl)
        return ProductDetailViewModel(product: product,
                                      imageLoader: imageLoader)
    }

    private func updateFilteredProducts() {
        models = filteredProducts
            .map { product in
                ProductListModel(id: product.id,
                                 cellViewModelProtocol: productCellViewModel(for: product),
                                 detailViewModelProtocol: productDetailViewModel(for: product))
            }
    }

    private func resetFilteredProducts() {
        filteredProducts = products
        noProductsMessage = products.isEmpty ? noProductsText : nil
        updateFilteredProducts()
    }
}

private extension Product {
    func search(on paths: [KeyPath<Product, String>], for searchText: String) -> Bool {
        paths.contains { path in
            self[keyPath: path].range(of: searchText, options: .caseInsensitive) != nil
        }
    }
}
