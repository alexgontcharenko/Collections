//
//  AppDelegate.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation

class Validators {
    
    static func isFilled(_ email: String?, _ password: String?, _ confirmPassword: String?) -> Bool {
        guard let email = email,
            let password = password,
            let confirmPassword = confirmPassword,
            password != "",
            confirmPassword != "",
            email != "" else { return false }
        return true
    }
    
    static func isFilled(name: String?, bornDate: String?, height: String?, address: String?, phone: String?) -> Bool {
        guard let name = name,
            let bornDate = bornDate,
            let height = height,
            let address = address,
            let phone = phone,
            name != "",
            bornDate != "",
            height != "",
            address != "",
            phone != "" else { return false }
        return true
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidNameField(name: String) -> Bool {
        if !name.isEmptyOrWhitespace() && name.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    static func isFilledTextFields(_ textOne: String?, _ textTwo: String?) -> Bool {
        guard let textOne = textOne, let textTwo = textTwo else { return false }
        guard !textOne.isEmpty && !textTwo.isEmpty else { return false }
        return true
    }
    
    static func isFilledTextFields(_ textOne: String?, _ textTwo: String?, _ textThree: String?) -> Bool {
        guard let textOne = textOne, let textTwo = textTwo, let textThree = textThree else { return false }
        guard !textOne.isEmpty && !textTwo.isEmpty && !textThree.isEmpty else { return false }
        return true
    }
    
    static func isPasswordsMatched(_ passOne: String?, _ passTwo: String?) -> Bool {
        guard let passOne = passOne, let passTwo = passTwo else { return false }
        guard passOne == passTwo else { return false }
        return true
    }
    
    static func isMissingSpaces(_ string: String?) -> Bool {
        guard let string = string else { return false }
        guard string.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 else { return false }
        return true
    }
    
    static func isValidPassword(myPassword : String) -> Bool {

        let passwordReg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}")
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTesting.evaluate(with: myPassword)
    }
}
