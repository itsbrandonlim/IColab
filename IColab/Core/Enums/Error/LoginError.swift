//
//  LoginError.swift
//  IColab
//
//  Created by Kevin Dallian on 08/12/23.
//

import Foundation

enum LoginError : Error{
    case invalidPassword
    case incompleteForm
    case firebaseError(Error)
}

extension LoginError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return NSLocalizedString("Invalid Username or Password", comment: "Login Error")
        case .incompleteForm:
            return NSLocalizedString("Username or Password is empty", comment: "Login Error")
        case .firebaseError(let authError):
            return NSLocalizedString("\(authError.localizedDescription)", comment: "Login Error")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .invalidPassword:
            return NSLocalizedString("Try Filling the right username of password", comment: "")
        case .incompleteForm:
            return NSLocalizedString("Cannot login when username or password is empty", comment: "")
        case .firebaseError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        }
    }
}
