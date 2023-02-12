//
//  Extensions.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import Foundation
import UIKit


extension UIButton {
    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
            color.setFill()
            UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
        }

        setBackgroundImage(colorImage, for: controlState)
    }
}


extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        return transition
    }
}
