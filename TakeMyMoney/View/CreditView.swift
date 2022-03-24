



import UIKit

class CreditView: UIView {
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardExpirationDate: UITextField!
    @IBOutlet weak var cardCVV: UITextField!
    @IBOutlet weak var cardHolderFullName: UITextField!

    @IBOutlet weak var invalidCardNumber: UILabel!
    @IBOutlet weak var invalidExpiration: UILabel!
    @IBOutlet weak var invalidCVV: UILabel!
    @IBOutlet weak var invalidName: UILabel!
}
