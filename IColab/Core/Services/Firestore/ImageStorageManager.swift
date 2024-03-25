//
//  ImageStorageManager.swift
//  IColab
//
//  Created by Jeremy Raymond on 25/03/24.
//

import SwiftUI
import FirebaseStorage

class ImageStorageManager: ObservableObject {
    let storage = Storage.storage()
    
    func upload(url: URL) throws {
        let storageRef = storage.reference().child("images/image.jpg")
        
        let data = try Data(contentsOf: url)
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            if let error = error {
                    print("Error while uploading file: ", error)
            }

            if let metadata = metadata {
                    print("Metadata: ", metadata)
            }
        }
    }
    
    func uploadData(image: UIImage) {
        let storageRef = storage.reference().child("images/image.jpg")

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                        print("Error while uploading file: ", error)
                }

                if let metadata = metadata {
                        print("Metadata: ", metadata)
                }
            }
        }
    }
    
    func uploadFile(url: URL) {
//        let data = Data()
//
//        // Create a reference to the file you want to upload
//        let storageRef = storage.reference()
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//            
//            print("successfully random upload")
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (downloadUrl, error) in
//            guard let downloadURL = downloadUrl else {
//              // Uh-oh, an error occurred!
//              return
//            }
//              print(downloadUrl)
//          }
//        }
        
        
        
//        let storageRef = storage.reference()
        let storageRef = storage.reference().child("payments/image.jpg")
        
        let uploadTask = storageRef.putFile(from: url, metadata: nil) { metadata, error in
            if let error = error {
                print(error.localizedDescription)
                print("Error while uploading file: ", error)
            }

            if let metadata = metadata {
                print("Metadata: ", metadata)
            }
//            guard let metadata = metadata else {
//                // Uh-oh, an error occurred!
//                return
//            }
//            // Metadata contains file metadata such as size, content-type.
//            let size = metadata.size
//            // You can also access to download URL after upload.
//            storageRef.downloadURL { (url, error) in
//                guard let downloadURL = url else {
//                  // Uh-oh, an error occurred!
//                  return
//                }
//            }
        }
    }
}
