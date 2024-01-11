//
//  DocumentPicker.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 1/7/24.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            DocumentPickerView()
        }
    }
}

struct DocumentPickerView: View {
    @State private var selectedURL: URL?
    @State var boole: Bool = false
    var body: some View {
        
        VStack {

            Button("Select Document") {
                boole.toggle()
            }
        }
        .fileImporter(
            isPresented:$boole
            ,
            allowedContentTypes: [UTType.data],
            onCompletion: { result in
                do {
                    selectedURL = try result.get()
                    if let url = selectedURL {
                        print("Selected document URL: \(url)")
                    }
                } catch {
                    print("Error selecting document: \(error.localizedDescription)")
                }
            }
        )
    }

    private func openDocumentPicker() {

    }
}


