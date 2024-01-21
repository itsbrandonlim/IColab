//
//  FormTextField.swift
//  IColab
//
//  Created by Kevin Dallian on 22/09/23.
//

import SwiftUI

struct FormTextField: View {
    var title : String
    @Binding var textField : String
    @State var letterCount = 0
    @FocusState var isFocused : Bool
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            HStack{
                TextField(title, text: $textField, axis: .vertical)
                    .autocorrectionDisabled()
                    .focused($isFocused)
                    .submitLabel(.continue)
                Button(action: { textField = "" }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.callout)
                })
                .buttonStyle(.plain)
            }
            Divider()
                .frame(height: 1.5)
                .overlay(.primary)
            HStack{
                Spacer()
                Text("\(letterCount)/150")
                    .font(.caption2)
            }
            .onChange(of: textField.count, perform: { value in
                letterCount = value
            })
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct FormTextField_Previews: PreviewProvider {
    static var previews: some View {
        FormTextField(title: "School", textField: .constant("BINUS University"))
    }
}
