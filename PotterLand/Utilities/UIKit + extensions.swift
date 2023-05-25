//
//  UIKit + extensions.swift
//  PotterLand
//
//  Created by Patka on 25/05/2023.
//

import UIKit

extension UIView {
    
    func constraint(to view: UIView, insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }
    
    func makeRound() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func makeRound(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
