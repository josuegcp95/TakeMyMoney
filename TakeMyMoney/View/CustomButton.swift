//
//  CustomButton.swift
//  TakeMyMoney
//
//  Created by Josue Cruz on 3/7/22.
//

import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 10.0
            clipsToBounds = true
    }
    
}
