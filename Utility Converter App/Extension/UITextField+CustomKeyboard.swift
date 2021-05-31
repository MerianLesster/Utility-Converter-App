//
//  UITextField+CustomNumericKeyboard.swift
//  Utility Converter App
//
//  Created by Damian Ranjit on 2021-03-17.
//

import UIKit

private var keyboardDelegate: CustomKeyboardDelegate? = nil


// MARK: - This extension can be used to make UITextFields as a part of the custom numeric keyboard.
extension UITextField: CustomKeyboardDelegate {
    
    /// This function sets the text field as a part of numeric keyboard.
    ///
    /// - Parameter delegate: The deligate
    func setAsNumericKeyboard(delegate: CustomKeyboardDelegate?) {
        let numericKeyboard = CustomKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: customNKbRecommendedHeight))
        self.inputView = numericKeyboard
        keyboardDelegate = delegate
        numericKeyboard.delegate = self
    }
    
    
    /// This function unsets the text field as a part of numeric keyboard.
    func unsetAsNumericKeyboard() {
        if let numericKeyboard = self.inputView as? CustomKeyboard {
            numericKeyboard.delegate = nil
        }
        self.inputView = nil
        keyboardDelegate = nil
    }
    
    /// This function handles the numeric key press. It inserts the
    /// corresponding numeric value to the text field text.
    ///
    /// - Parameter key: The numeric key pressed.
    internal func numericKeyPressed(key: Int) {
        self.insertText(String(key))
        keyboardDelegate?.numericKeyPressed(key: key)
    }
    
    
    /// This function handles the backspace key press. It removes a charater
    /// from the inserted text in the text field.
    internal func numericBackspacePressed() {
        self.deleteBackward()
        keyboardDelegate?.numericBackspacePressed()
    }
    
    
    /// This function handles the symbol key press. It inserts the
    /// corresponding symbol to the text field text.
    ///
    /// - Parameter symbol: The symbol pressed.
    internal func numericSymbolPressed(symbol: String) {
        self.insertText(String(symbol))
        keyboardDelegate?.numericSymbolPressed(symbol: symbol)
    }
}

