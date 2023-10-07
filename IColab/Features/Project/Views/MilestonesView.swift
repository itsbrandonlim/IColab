//
//  MilestonesView.swift
//  IColab
//
//  Created by Jeremy Raymond on 24/09/23.
//

import SwiftUI

struct MilestonesView: View {
    var milestone: Milestone
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        MilestoneInfoView(title: "Total Milestone", value: "6", measurement: "Milestone")
                        Divider()
                            .frame(height: 32)
                        MilestoneInfoView(title: "Average Length", value: "2.2 ", measurement: "Days")
                        Divider()
                            .frame(height: 32)
                        MilestoneInfoView(title: "Average Payment", value: "5.525.000", measurement: "Rp")
                    }
                    .padding()
                    .background(Color("gray"))
                    .cornerRadius(12)
                    MilestoneLineView(milestone: milestone)
                }
            }
            .navigationTitle("Milestone")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddGoalView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }

                }
            }
        }
        
    }
}

//struct MilestonesView_Previews: PreviewProvider {
//    static var previews: some View {
//        MilestonesView()
//            .preferredColorScheme(.dark)
//    }
//}
