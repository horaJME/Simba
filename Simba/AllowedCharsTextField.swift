//
//  AllowedCharsTextField.swift
//  Simba
//
//  Created by Infinum on 16/01/17.
//  Copyright © 2017 Infinum. All rights reserved.
//

import Foundation

import UIKit


class AllowedCharsTextField: MaxLengthTextField {
    
    // 1
    @IBInspectable var allowedChars: String = ""
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        // 2
        autocorrectionType = .no
    }
    
    // 3
    override func allowedIntoTextField(text: String) -> Bool {
        return super.allowedIntoTextField(text: text) &&
            text.containsOnlyCharactersIn(matchCharacters: allowedChars)
    }
    
}


// 4
private extension String {
    
    // Returns true if the string contains only characters found in matchCharacters.
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    
}
