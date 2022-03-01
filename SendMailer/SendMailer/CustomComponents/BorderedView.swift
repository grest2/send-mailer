//
//  CircleView.swift
//  SendMailer
//
//  Created by iOS Developer on 3/1/22.
//

import Foundation
import UIKit

@IBDesignable
class BorderedView: UIView {
    /* ----- Properties ----- */

    /* Border settings */
    @IBInspectable var borderRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    /* ----- Methods ----- */

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        self.initialize()
    }

    private func initialize() {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
}
