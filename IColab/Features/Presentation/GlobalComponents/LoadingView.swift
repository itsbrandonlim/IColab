//
//  LoadingView.swift
//  IColab
//
//  Created by Kevin Dallian on 08/12/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false

    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.white, lineWidth: 4)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                        self.isLoading = true
                    }
                }
        }
    }
}

#Preview {
    LoadingView()
}
