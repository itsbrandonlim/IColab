//
//  DocumentPicker.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 1/7/24.
//

import Foundation
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

    var body: some View {
        VStack {
            Button("Select Document") {
                openDocumentPicker()
            }
        }
        .fileImporter(
            isPresented: Binding<Bool>(
                get: { selectedURL == nil },
                set: { _ in }
            ),
            allowedContentTypes: [UTType.data],
            onCompletion: { result in
                do {
                    selectedURL = try result.get()
                    if let url = selectedURL {
                        print("Selected document URL: \(url)")
                    }
                } catch {
                    // Handle error
                    print("Error selecting document: \(error.localizedDescription)")
                }
            }
        )
    }

    private func openDocumentPicker() {
       
    }
}


