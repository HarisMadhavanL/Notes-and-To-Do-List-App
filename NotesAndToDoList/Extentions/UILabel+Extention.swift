//
//  UILabel+Extention.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 04/12/24.
//

import Foundation
import UIKit

extension UILabel {
    func strikethroughText(_ strikethroughText: String) {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: strikethroughText)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 0, length: attributeString.length))
        self.attributedText = attributeString
    }
    
    func removeStrikethroughText(_ strikethroughText: String) {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: strikethroughText)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 0, range: NSRange(location: 0, length: attributeString.length))
        self.attributedText = attributeString
    }
    
    var isStrikethrough: Bool {
        guard let attributedText = self.attributedText else { return false }
        var hasStrikethrough = false
        attributedText.enumerateAttribute(.strikethroughStyle, in: NSRange(location: 0, length: attributedText.length)) { value, _, _ in
            if let style = value as? Int, style == NSUnderlineStyle.single.rawValue {
                hasStrikethrough = true
            }
        }
        return hasStrikethrough
    }
}
