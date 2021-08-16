//
//  Endpoint.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import Foundation
import os

protocol EndpointProtocol {
    var request: URLRequest? { get }
}

struct Endpoint {
    // MARK: Private Properties

    private let scheme: String
    private let host: String
    private let port: Int?
    private let path: EndpointPath
    private let method: EndpointMethod

    // MARK: Lifecycle

    init(scheme: String = "http",
         host: String = "localhost",
         port: Int? = nil,
         path: EndpointPath,
         method: EndpointMethod) {
        self.scheme = scheme
        self.host = host
        self.port = port
        self.path = path
        self.method = method
    }

    // MARK: Public Properties

    var request: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = path.rawValue
        guard let url = urlComponents.url else {
            assertionFailure("⚠️ This should never happen. Couldn't make URLRequest from Endpoint.")
            let text: StaticString = "Couln't convert URLComponents to url. Scheme: %@, host: %@, port: %@, path: %@"
            let port = port != nil ? String(describing: port) : "none"
            os_log(text, type: .error, scheme, host, port, path.rawValue)
            return nil
        }

        var request = URLRequest(url: url)
        switch method {
        case .get:
            request.httpMethod = "GET"
        case let .post(body):
            request.httpMethod = "POST"
            request.httpBody = body
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        }
        return request
    }
}

enum EndpointPath {
    case products
    case reviews(productId: String)
}

enum EndpointMethod {
    case get
    case post(Data)
}

extension EndpointPath: RawRepresentable {
    typealias RawValue = String

    init?(rawValue: String) {
        switch rawValue {
        case "/product":
            self = .products
        default:
            if rawValue.hasPrefix("/reviews/"),
               let productId = rawValue.components(separatedBy: "/").last,
               !productId.isEmpty {
                self = .reviews(productId: productId)
            }
            return nil
        }
    }

    var rawValue: String {
        switch self {
        case .products:
            return "/product"
        case let .reviews(productId):
            return "/reviews/" + productId
        }
    }
}
