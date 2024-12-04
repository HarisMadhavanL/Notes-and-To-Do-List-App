//
//  UITextView+Extention.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 04/12/24.
//

import Foundation
import UIKit

extension UITextView {
    func applyTextViewStyle(cornerRadius: CGFloat = 5, borderWidth: CGFloat = 0.8, borderColor: UIColor = .gray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
