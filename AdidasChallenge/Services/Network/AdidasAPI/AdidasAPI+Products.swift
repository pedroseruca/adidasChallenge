//
//  AdidasAPI+Products.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Combine

protocol AdidasAPIProductsProtocol {
    func getProducts() -> AnyPublisher<Products, Error>
}

extension AdidasAPI: AdidasAPIProductsProtocol {
    func getProducts() -> AnyPublisher<Products, Error> {
        let endpoint = Endpoint(port: 3001,
                                path: .products,
                                method: .get)
        guard let request = endpoint.request else { return noUrlRequestPublisher() }

        return serviceManager.execute(request: request,
                                      decodingType: Products.self,
                                      receiveOn: .main)
    }
}
