//
//  PaymentUploadView.swift
//  IColab
//
//  Created by Jeremy Raymond on 25/03/24.
//

import SwiftUI

struct PaymentUploadView: View {
    @State var importing = false
    
    var dataManager = ImageStorageManager()
    
    var body: some View {
        VStack {
            Image(.uploadDocument)
                .resizable()
                .frame(width: 260, height: 260)
                .padding(.vertical)
            Text("Upload Payment Detail")
                .font(.title)
            Text("Upload payment proof in the form of image")
            Text("Max File Size: 15kb")
                .font(.footnote)
            Button(action: {
                importing.toggle()
            }, label: {
                Image(systemName: "plus.app")
                    .resizable()
                    .frame(width: 64, height: 64)
            })
            .padding(.vertical)
            .fileImporter(isPresented: $importing, allowedContentTypes: [.pdf, .image]) { result in
                switch result {
                case .success(let file):
                    let gotAccess = file.startAccessingSecurityScopedResource()
                   if !gotAccess { return }
                   // access the directory URL
                   // (read templates in the directory, make a bookmark, etc.)
                    print("File is: ", file)
                    do {
                        try dataManager.upload(url: file)
                    }
                    catch {
                        print("Error while uploading")
                    }
                   // release access
                   file.stopAccessingSecurityScopedResource()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    PaymentUploadView()
}
