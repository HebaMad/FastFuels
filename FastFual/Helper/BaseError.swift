//
//  BaseError.swift
//  Tahadi
//
//  Created by iOS Developer on 7/27/19.
//  Copyright © 2019 iOS Developer. All rights reserved.
//
//import KOLocalizedString
import Foundation

enum BaseError: Error {
    
    
case inValidToken
    case authLogin
    case authProduct
    case decodeResponse
    
    
    
    case orderError
    case none
    case other(title:String)
    case emptyUserName
    case inValidEmail
    case inValidPasswordCount
    case inValidEnterPassword
    case misMatchPassword
    case inValidMobile
    case inValidCode
    case selectedCountry
    case selectedTeam

}

extension BaseError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .authProduct:
            return "To enjoy this product you need to login"
            
        case .authLogin:
            return "Please login"
        case .orderError:
            return "OrderError"
        case .none:
            return ""
        case .other(let title):
            return title
        case .decodeResponse:
            return "Can't map response."
        case .emptyUserName:
            return "Please enter correct user name"
        case .inValidEmail:
            return "Please enter valid email"
        case .inValidPasswordCount:
            return "Please enter at least 6 characters"
        case .inValidMobile:
            return "Please enter valid mobile number"
            
        case .inValidEnterPassword:
            return "Please enter password"
        case .selectedCountry:
            return "Please select country"
        case .misMatchPassword:
            return "Password mismatch"
        case .selectedTeam:
            return "Please select team"
        case .inValidCode:
            return "Please enter 4 Digits"
            
            case .inValidToken:
                       return "KeyGotoLogin"  //KOLocalizedString("KeyGotoLogin")
        }
    }
}
