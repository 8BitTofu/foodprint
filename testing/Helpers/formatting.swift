//
//  formatting.swift
//  testing
//
//  Created by Austin Leung on 2/19/21.
//

import Foundation
import UIKit

func makeGhostButton(button: UIButton, color: UIColor) {
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 1
    button.layer.borderColor = color.cgColor
    button.setTitleColor(color, for: .normal)
    button.backgroundColor = .white
}

func makeSolidButton(button: UIButton, backgroundColor: UIColor, textColor: UIColor) {
    button.layer.cornerRadius = 10
    button.backgroundColor = backgroundColor
    
    button.setTitleColor(textColor, for: .normal)
}

func makeSolidLabel(label: UILabel, backgroundColor: UIColor, textColor: UIColor) {
    // label.layer.cornerRadius = 10
    label.backgroundColor = backgroundColor
    
    label.textColor = textColor
}
