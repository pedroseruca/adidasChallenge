//
//  AddReviewView.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 16/08/2021.
//

import SwiftUI

struct AddReviewView: View {
    @Environment(\.presentationMode) var presentation
    
    private var viewModel: AddReviewViewModel
    
    init(viewModel: AddReviewViewModel) {
        self.viewModel = viewModel
    }
    
    @State private var text: String = ""
    @State private var rating: Float = 5
    
    private var ratingRound: Int { Int(rating)}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.titleLabel)
                .font(.title2)
                .padding(.bottom, 10)
            HStack {
                Text("\(ratingRound)")
                    .font(.title2)
                Slider(value: $rating, in: 0...10, step: 1)
            }
            Text(viewModel.shareOpinionLabel)
                .font(.title3)
            TextEditor(text: $text)
                .frame(maxHeight: 300)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1.5)
                )
            Button(viewModel.buttonTitle) {
                viewModel.buttonPressed(rating: ratingRound, text: text)
            }
            .padding(0)
            .buttonStyle(PrimaryButtonStyle(color: .black))
                
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(viewModel.navigationTitle)
        .onReceive(viewModel.onSuccessSubmitPublisher) { _ in
            self.presentation.wrappedValue.dismiss()
        }
        
    }
}

//struct AddReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddReviewView()
//            .previewLayout(.sizeThatFits)
//    }
//}
