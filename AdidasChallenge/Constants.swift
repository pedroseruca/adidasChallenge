//
//  ImageLoader.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 14/08/2021.
//

import SwiftUI

enum Constants {
    enum Network {
        enum HTTPError: LocalizedError {
            case statusCode
            case noUrlRequest
            case couldntEncodeObject
        }
    }

    enum Style {
        enum ProductCell {
            static let imageSize: CGFloat = 120
            static let padding: CGFloat = 10
            static let imageLeadingPadding: CGFloat = 10
            static let imageCornerRadius: CGFloat = 5
            static let progressViewScale: CGFloat = 1.5
            static let noImageAsset = "NoImageAvailable"
        }

        enum ProductReviewCell {
            static let minWidth: CGFloat = 25
        }

        enum ProductReviewsContent {
            static let padding: CGFloat = 15
        }

        enum ProductReviewsView {
            static let productReviewsHeaderPadding: CGFloat = 15
        }

        enum AddReviewView {
            static let titlePadding: CGFloat = 10
            static let buttonBorderColor: Color = .black
            static let buttonBorderPadding: CGFloat = 0
            
            enum TextEditor {
                static let maxHeight: CGFloat = 300
                static let cornerRadius: CGFloat = 8
                static let lineWidth: CGFloat = 1.5
            }
        }
        
        enum ProductListView {
            static let progressViewScale: CGFloat = 2
        }
        
        enum ProductDetailView {
            static let progressViewPadding: CGFloat = 10
            static let progressViewScale: CGFloat = 2
            static let noImageAsset = "NoImageAvailable"
            static let noImageSize: CGFloat = 300
        }
    }
}
