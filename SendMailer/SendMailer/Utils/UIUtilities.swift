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
    
    public static func alertPresent(title: String, message: String, action: UIAlertAction, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        controller.present(alert, animated: true)
    }
}

