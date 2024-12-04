//
//  UITextField+Extention.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 04/12/24.
//

import Foundation
import UIKit

extension UITextField {
    func applyTextFieldStyle(cornerRadius: CGFloat = 5, borderWidth: CGFloat = 0.8, borderColor: UIColor = .gray, leftPadding: CGFloat = 5, placeholderText: String, placeholderColor: UIColor = .lightGray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: self.frame.height))
        self.leftViewMode = .always
        self.leftView = paddingView
        
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: placeholderColor])
    }
}

