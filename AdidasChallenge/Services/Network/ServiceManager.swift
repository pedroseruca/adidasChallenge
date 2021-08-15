//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 14/08/2021.
//

import Combine
import Foundation

protocol ServiceManagerProtocol {
    func execute(request: URLRequest,
                 receiveOn queue: DispatchQueue) -> AnyPublisher<Void, Error>

    func execute<T>(request: URLRequest,
                    decodingType: T.Type,
                    receiveOn queue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable
}

final class ServiceManager: ServiceManagerProtocol {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func execute<T>(request: URLRequest,
                    decodingType: T.Type,
                    receiveOn queue: DispatchQueue = .main) -> AnyPublisher<T, Error> where T: Decodable {
        dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: decodingType, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }

    func execute(request: URLRequest,
                 receiveOn queue: DispatchQueue = .main) -> AnyPublisher<Void, Error> {
        dataTaskPublisher(for: request)
            .map { _ in () }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }

    private func dataTaskPublisher(for request: URLRequest) -> Publishers.TryMap<URLSession.DataTaskPublisher, URLSession.DataTaskPublisher.Output> {
        session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard
                    let response = output.response as? HTTPURLResponse,
                    200...300 ~= response.statusCode else {
                    throw Constants.Network.HTTPError.statusCode
                }
                return output
            }
    }
}
