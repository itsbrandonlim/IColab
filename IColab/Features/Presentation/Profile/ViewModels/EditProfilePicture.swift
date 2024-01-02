//
//  EditProfilePicture.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 1/2/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct ScreeningImage: View {
    let imageState: ImagePickerManager.ImageState
    
    var body: some View {
        ZStack {
            Image("purple")
                .resizable()
                .frame(width: 72, height: 72)
                .cornerRadius(12)
            
            VStack {
                Spacer()
                Text("Edit")
                    .font(.caption2)
                    .frame(width: 72)
                    .cornerRadius(12)
                    .background(.ultraThickMaterial)
            }
        }
        .overlay {
            switch imageState {
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            case .loading:
                ProgressView()
            case .empty:
                EmptyView()
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}



struct EditableScreeningImage: View {
    @ObservedObject var imagePicker: ImagePickerManager
    
    var body: some View {
        ScreeningImage(imageState: imagePicker.imageState)
            .overlay(alignment: imagePicker.imageState == .empty ? .center : .topTrailing) {
                PhotosPicker(selection: $imagePicker.imageSelection,
                             matching: .images,
                             photoLibrary: .shared())
                {
                    switch imagePicker.imageState {
                    case .empty:
                    Text("test")
                    case .success(_):
                        Circle()
                            .frame(width: 36)
                            .overlay {
                                Image(systemName: "pencil")
                            }
                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.yellow)
                    default:
                        EmptyView()
                    }
                }
                .buttonStyle(.borderless)
                .padding(8)
            }
    }
}

struct ScreeningImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        EditableScreeningImage(imagePicker: ImagePickerManager())
            .previewLayout(.sizeThatFits)
    }
}

