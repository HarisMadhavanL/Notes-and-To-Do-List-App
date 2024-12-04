//
//  UIView+Extention.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 04/12/24.
//

import Foundation
import UIKit

extension UIView {
    func applyCornerRadiusAndShadow(cornerRadius: CGFloat = 12, shadowColor: UIColor = .gray, shadowOpacity: Float = 0.2, shadowOffset: CGSize = CGSize(width: 0.4, height: 0), shadowRadius: CGFloat = 8) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}

