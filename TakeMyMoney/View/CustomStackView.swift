



import UIKit

class CustomStackView: UIStackView {

    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 10.0
            clipsToBounds = true
    }

}
