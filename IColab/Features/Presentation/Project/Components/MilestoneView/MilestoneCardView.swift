//
//  MilestoneCardView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct MilestoneCardView: View {
    var goal: Goal
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(goal.name)
                    .font(.headline)
                Text(goal.desc)
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                HStack {
                    Spacer()
                    Text("Rp. \(goal.nominal.formatted())")
                    Spacer()
                }
                .padding(.vertical, 12)
                .background(.purple)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            CurrentMilestoneDateView(date: goal.endDate)
            
        }
        .padding()
        .background(Color("gray"))
        .cornerRadius(12)
    }
}

//struct MilestoneCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MilestoneCardView()
//            .preferredColorScheme(.dark)
//    }
//}
