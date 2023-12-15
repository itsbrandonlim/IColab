//
//  AnyAnimation.swift
//  IColab
//
//  Created by Kevin Dallian on 12/12/23.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
