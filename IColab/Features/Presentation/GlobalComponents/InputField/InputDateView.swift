//
//  InputDateView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct InputDateView: View {
    @Binding var date: Date
    var title : String
    
    init(date: Binding<Date>, title: String = "Input Date") {
        self._date = date
        self.title = title
    }
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(self.title)
                    .font(.headline)
                HStack {
                    DatePicker("Date Picker", selection: $date, displayedComponents: .date)
                        .labelsHidden()
                    Spacer()
                    Image(systemName: "calendar")

                    
                }
                Divider()
                    .foregroundColor(.white)
            }
            
            //Text("Date is \(date.formatted(date: .long, time: .omitted))")
        }
    }
}

struct InputDateView_Previews: PreviewProvider {
    static var previews: some View {
        InputDateView(date: .constant(Date.now))
    }
}
