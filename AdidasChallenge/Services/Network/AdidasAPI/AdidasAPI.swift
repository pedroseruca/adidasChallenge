//
//  AdidasAPIProvider.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Combine
import Foundation

class AdidasAPI: AdidasAPIProtocol {
    let serviceManager: ServiceManagerProtocol

    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
}

// MARK: Error handling

extension AdidasAPI {
    func noUrlRequestPublisher<T>() -> AnyPublisher<T, Error> {
        Future { $0(.failure(Constants.Network.HTTPError.noUrlRequest)) }
            .eraseToAnyPublisher()
    }

    func couldntEncodeObjectPublisher<T>() -> AnyPublisher<T, Error> {
        Future { $0(.failure(Constants.Network.HTTPError.couldntEncodeObject)) }
            .eraseToAnyPublisher()
    }
}
