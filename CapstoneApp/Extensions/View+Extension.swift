//
//  View+Extension.swift
//  CapstoneApp
//
//  Created by Consultant on 1/28/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{

    
    func addShadow() {

    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    self.layer.shadowRadius = 2.0
    self.layer.shadowOpacity = 1.0
    self.layer.masksToBounds = false

    }
}
