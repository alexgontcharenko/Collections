//
//  Validators.swift
//  VINdecode
//
//  Created by Steew on 05.07.2020.
//  Copyright © 2020 Steew. All rights reserved.
//

import Foundation

func isValidNameField(text: String) -> Bool {
    if !text.isEmptyOrWhitespace() && text.count == 17 {
        return true
    } else {
        return false
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        if self.isEmpty {
            return true
        }
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}
