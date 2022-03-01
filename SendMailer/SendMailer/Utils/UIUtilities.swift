//
//  UIUtilities.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import UIKit

class UIUtilities {
    public static func applyTap(action: Selector?, initer: Any?, target: UIView!, cancelsTouches: Bool? = nil) {
        if let _target = target {
            _target.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: initer, action: action)
            if let cancelsTouches = cancelsTouches {
                tap.cancelsTouchesInView = cancelsTouches
            }
            _target.addGestureRecognizer(tap)
        }
    }
}

