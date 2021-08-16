//
//  MockServiceManager.swift
//  AdidasChallengeTests
//
//  Created by Pedro Seruca on 16/08/2021.
//

import Foundation

@testable import AdidasChallenge
import Combine

class MockServiceManager: ServiceManagerProtocol {
    private(set) var lastRequest: URLRequest?
    private(set) var isExecuteCalled = false

    func execute(request: URLRequest, receiveOn queue: DispatchQueue) -> AnyPublisher<Void, Error> {
        lastRequest = request
        isExecuteCalled = true
        return Future { $0(.failure(GenericError.standard)) }
            .eraseToAnyPublisher()
    }

    func execute<T>(request: URLRequest, decodingType: T.Type, receiveOn queue: DispatchQueue) -> AnyPublisher<T, Error> where T: Decodable {
        lastRequest = request
        isExecuteCalled = true
        return Future { $0(.failure(GenericError.standard)) }
            .eraseToAnyPublisher()
    }
}
