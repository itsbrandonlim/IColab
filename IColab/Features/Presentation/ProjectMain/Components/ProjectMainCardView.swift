//
//  ProjectMainCardView.swift
//  IColab
//
//  Created by Brandon Nicolas Marlim on 10/2/23.
//

import SwiftUI

struct ProjectMainCardView: View {
    var project: Project
    @State var status: Bool = true
    @State var isLoading : Bool = true
    @State var owner: AccountDetail!
    var fetchOwner = FetchDocumentFromIDUseCase()
    var body: some View {
        if isLoading {
            LoadingView()
                .onAppear{
                    fetchOwner.call(collectionName: "accountDetails", id: project.owner!) { document in
                        if let doc = document.data(){
                            let accountDetail = AccountDetail.decode(from: doc)
                            self.owner = accountDetail
                            self.isLoading = false
                        }
                    }
                }
        }else {
            HStack {
                Rectangle()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(project.projectState != .overdue ? .purple : .red)
                    .cornerRadius(12)
                VStack(alignment: .leading) {
                    Text(project.title)
                        .font(.headline)
                    Text(owner.name)
                        .font(.caption2)
                    if project.projectState != .overdue {
                        HStack {
                            ProgressView(value: 0.75)
                                .tint(.purple)
                                .frame(width: 200)
                            Text("75%")
                                .font(.headline)
                        }
                    }
                    else {
                        Text("Overdue")
                            .font(.footnote)
                            .padding(.vertical, 4)
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(12)
                    }
                }
                Spacer()
            }
            .frame(width: 332)
            .padding()
            .background(Color(.gray))
            .cornerRadius(12)
        }
        
        
        
    }
}

//#Preview {
//    ProjectMainCardView()
//        .preferredColorScheme(.dark)
//}

