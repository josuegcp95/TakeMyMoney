//
//  CustomStackView.swift
//  TakeMyMoney
//
//  Created by Josue Cruz on 3/7/22.
//

import UIKit

class CustomStackView: UIStackView {

    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 10.0
            clipsToBounds = true
    }

}
