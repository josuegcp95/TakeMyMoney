



import UIKit

class CustomButton: UIButton {

    override func awakeFromNib() {
            super.awakeFromNib()
            layer.cornerRadius = 10.0
            clipsToBounds = true
    }
    
}
