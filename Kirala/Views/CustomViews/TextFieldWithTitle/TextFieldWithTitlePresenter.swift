//
//  TextFieldWithTitlePresenter.swift
//  SwiftTips
//
//  Created by Ali Çolak on 8.06.2024.
//

import Foundation

enum TextFieldWithTitleType {
    case name
    case price
    case description
}

struct TextFieldWithTitleViewArguments {
    let title: String
    let placeholder: String
    let tip: String
    let text: String?
    let type: TextFieldWithTitleType
}

protocol TextFieldWithTitleDelegate: AnyObject {
    func textFieldDidChanged(_ text: String, type: TextFieldWithTitleType)
}

protocol TextFieldWithTitlePresenterProtocol {
    var delegate: TextFieldWithTitleDelegate? { get set }
    func load()
    func getPleaceholder() -> String
    func shouldChangeCharactersIn(range: NSRange, replacementString string: String, text: String) -> Bool
    func textViewTextDidChange(_ text: String)
}

protocol TextFieldWithTitleViewProtocol: AnyObject {
    func prepareTextField()
    func setTextFieldTitle(_ title: String)
    func setTextFieldPlaceholder(_ placeholder: String)
    func setTextFieldTip(_ tip: String)
    func setTextFieldText(_ text: String)
    func setTextViewText(_ text: String)
    func setTextViewPlaceholder(_ placeholder: String)
    func setTextViewTip(_ tip: String)
    func setTextFieldType(_ type: TextFieldWithTitleType)
}


final class TextFieldWithTitlePresenter: TextFieldWithTitlePresenterProtocol {
    
    weak var delegate: TextFieldWithTitleDelegate?
    private let view: TextFieldWithTitleViewProtocol
    private let arguments: TextFieldWithTitleViewArguments
    
    init(view: TextFieldWithTitleViewProtocol, arguments: TextFieldWithTitleViewArguments) {
        self.view = view
        self.arguments = arguments
    }
    
    func load() {
        view.prepareTextField()
        view.setTextFieldTitle(arguments.title)
        view.setTextFieldPlaceholder(arguments.placeholder)
        
        switch arguments.type {
        case .name, .price:
            view.setTextFieldTip(arguments.tip)
            if let text = arguments.text {
                view.setTextFieldText(text)
            }
        case .description:
            view.setTextViewTip(arguments.tip)
            if let text = arguments.text {
                view.setTextViewText(text)
            } else {
                view.setTextViewPlaceholder(arguments.placeholder)
            }
        }
        
        view.setTextFieldType(arguments.type)
        
    }
    
    
    
    func getPleaceholder() -> String {
        return arguments.placeholder
    }
    
    func shouldChangeCharactersIn(range: NSRange, replacementString string: String, text: String) -> Bool {
        switch arguments.type {
        case .name, .description:
            textFieldDidChanged(text)
            return true
        case .price:
            let allowedCharacters = CharacterSet(charactersIn: "0123456789.,")
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
            
            // Get the current text
            if let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                
                // Replace commas with periods to handle decimal separator uniformly
                let standardizedText = updatedText.replacingOccurrences(of: ",", with: ".")
                
                // Update the text field with the standardized text
                view.setTextFieldText(standardizedText)
                
                // Notify the delegate about the text change
                textFieldDidChanged(standardizedText)
                
                return false // Return false since we manually updated the text
            }
            
            return true
        }
    }
    
    func textViewTextDidChange(_ text: String) {
        textFieldDidChanged(text)
    }
    
    private func textFieldDidChanged(_ text: String) {
        delegate?.textFieldDidChanged(text, type: arguments.type)
    }
    
}


