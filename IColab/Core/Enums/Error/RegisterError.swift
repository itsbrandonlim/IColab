//
//  RegisterError.swift
//  IColab
//
//  Created by Kevin Dallian on 08/12/23.
//

import Foundation

enum RegisterError : Error {
    case formIncomplete
    case shortUsername
    case notEmailFormat
    case passwordLessThan8
    case phoneNotNumber
    case firebaseError(Error)
}

extension RegisterError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .formIncomplete:
            return NSLocalizedString("Form not Filled", comment: "")
        case .shortUsername:
            return NSLocalizedString("Short Username", comment: "")
        case .notEmailFormat:
            return NSLocalizedString("Email Format Required", comment: "")
        case .passwordLessThan8:
            return NSLocalizedString("Short Password", comment: "")
        case .phoneNotNumber:
            return NSLocalizedString("Phone Number contains letters", comment: "")
        case .firebaseError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .formIncomplete:
            return NSLocalizedString("Make sure all form is filled.", comment: "")
        case .shortUsername:
            return NSLocalizedString("Username must be more than 8 characters.", comment: "")
        case .notEmailFormat:
            return NSLocalizedString("Email must have @ character.", comment: "")
        case .passwordLessThan8:
            return NSLocalizedString("Password must contain more than 8 characters.", comment: "")
        case .phoneNotNumber:
            return NSLocalizedString("Make sure phone number is filled with numbers only.", comment: "")
        case .firebaseError(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        }
    }
    
}
