//
//  ContactCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct ContactCardView: View {
    var member: AccountDetail
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 48)
                .foregroundColor(Color(.purple))
            VStack(alignment: .leading) {
                Text(member.name)
                Divider()
            }
            Spacer()
            
        }
    }
}

//struct ContactCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactCardView()
//    }
//}
