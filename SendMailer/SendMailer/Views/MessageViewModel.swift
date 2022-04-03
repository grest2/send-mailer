//
//  MessageView.swift
//  SendMailer
//
//  Created by iOS Developer on 4/3/22.
//

import Foundation
import UIKit

class MessageView: UIView {
    public func initialize() {
        self.messageBodyLayout()
    }
    
    public func messageBodyLayout() {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
