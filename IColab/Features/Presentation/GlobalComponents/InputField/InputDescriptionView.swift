//
//  InputDescriptionView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct InputDescriptionView: View {
    var title: String = "Input Description"
    @Binding var text: String
    @FocusState private var isFocused : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            HStack {
                TextEditor(text: $text)
                    .autocorrectionDisabled()
                    .frame(height: 120)
                    .foregroundColor(.gray.opacity(0.75))
                    .focused($isFocused)
                Spacer()
                Button {
                    text = ""
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            Divider()
                .foregroundColor(.white)
            HStack {
                Spacer()
                Text("\(text.count)/150")
                    .font(.caption2)
            }
        }
//        .toolbar {
//            ToolbarItem(placement: .keyboard) {
//                if isFocused {
//                    Button("Done") {
//                        isFocused = false
//                    }
//                }
//            }
//        }
    }
}

struct InputDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        InputDescriptionView(text: .constant(""))
    }
}
