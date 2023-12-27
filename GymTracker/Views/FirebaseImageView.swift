//
//  FirebaseImageView.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import SwiftUI
import FirebaseStorage

struct FirebaseImageView: View {
    let imageName: String
    @State private var imageUrl: URL?

    var body: some View {
        VStack {
            if let imageUrl = imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            fetchImage()
        }
    }

    private func fetchImage() {
        let storage = Storage.storage()
        let storageRef = storage.reference().child("images/\(imageName)")

        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error getting image URL: \(error)")
                return
            }
            imageUrl = url
        }
    }
}

#Preview {
    FirebaseImageView(imageName: "Squat")
}
