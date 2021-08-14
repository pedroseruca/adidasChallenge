//
//  SearchBar.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 14/08/2021.
//

import SwiftUI

struct SearchBar: View {
    var onSearchText: (String) -> Void
    @State private var searchText: String = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("search", text: $searchText, onEditingChanged: { _ in
                    showCancelButton = true
                }, onCommit: {
                    onSearchText(searchText)
                }).foregroundColor(.primary)

                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText.isEmpty ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 10, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if showCancelButton {
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    searchText = ""
                    showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""
    static var previews: some View {
        SearchBar { _ in }
            .previewLayout(.sizeThatFits)
    }
}
