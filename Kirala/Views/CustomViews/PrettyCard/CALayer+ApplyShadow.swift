//
//  CALayer+ApplyShadow.swift
//  Kirala
//
//  Created by Ali Çolak on 28.05.2024.
//

import UIKit

public extension CALayer {

    func applyCardShadow(_ shadow: Card.Shadow) {
        self.shadowColor = shadow.color?.cgColor
        self.shadowOffset = shadow.offset
        self.shadowOpacity = shadow.opacity
        self.shadowRadius = shadow.radius
    }

}
