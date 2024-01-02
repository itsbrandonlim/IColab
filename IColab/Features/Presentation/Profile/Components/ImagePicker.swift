//
//  ImagePicker.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 1/2/24.
//
//
import Foundation
import SwiftUI
import PhotosUI
import CoreTransferable

class ImagePickerManager: ObservableObject {
    enum ImagePickerError: Error {
        case importFailed
    }

    enum ImageState: Equatable {
        case empty
        case loading(Progress)
        case success(UIImage)
        case failure(Error)

        static func == (lhs: ImageState, rhs: ImageState) -> Bool {
            switch (lhs, rhs) {
            case (.empty, .empty):
                return true
            case (.loading, .loading):
                return true
            case let (.success(lhsImage), .success(rhsImage)):
                return lhsImage == rhsImage
            case (.failure, .failure):
                return true
            default:
                return false
            }
        }
    }

    @Published private(set) var imageState: ImageState = .empty

    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection = imageSelection {
                loadImage(from: imageSelection)
            } else {
                imageState = .empty
            }
        }
    }

    private func loadImage(from imageSelection: PhotosPickerItem) {
        imageState = .loading(Progress())
        imageSelection.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let data?):
                    if let uiImage = UIImage(data: data) {
                        self.imageState = .success(uiImage)
                    } else {
                        self.imageState = .failure(ImagePickerError.importFailed)
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

