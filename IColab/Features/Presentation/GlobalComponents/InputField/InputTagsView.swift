//
//  InputTagsView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct InputTagsView: View {
    @Binding var tags: [String]
    @State var popupToggle: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Input Tags")
                        .font(.headline)
                    Spacer()
                    Button {
                        withAnimation {
                            popupToggle.toggle()
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(.plain)
                }
                HStack {
                    ForEach(tags, id: \.self) { tag in
                        Button(action: {
                            let index = tags.firstIndex(of: tag)
                            if let idx = index {
                                withAnimation(.easeInOut) {
                                    tags.remove(at: idx)
                                }
                            }
                        }, label: {
                            TagItem(tagText: tag)
                        })
                        
                    }
                }
                Divider()
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $popupToggle, content: {
                InputTagPopupView(tag: $tags, popupToggle: $popupToggle)
                    .presentationDetents([.fraction(0.3)])
            })
        }
        
    }
}

//struct InputTagsView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputTagsView(tags: .constant([]))
//            .preferredColorScheme(.dark)
//    }
//}
