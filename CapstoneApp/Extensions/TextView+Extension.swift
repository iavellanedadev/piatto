//
//  TextView+Extension.swift
//  CapstoneApp
//
//  Created by Consultant on 2/6/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import Foundation
import UIKit

extension UITextView
{
    func setBorder()
    {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = CGFloat(1.0)
    }
}
