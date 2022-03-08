



import UIKit

class CreditCardViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardExpirationDate: UITextField!
    @IBOutlet weak var cardCVV: UITextField!
    @IBOutlet weak var cardHolderFullName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    
    // ACTIONS
    @IBAction func creditTapped (_ sender: UIButton) {
    }
    
    @IBAction func paypalTapped (_ sender: UIButton) {
    }
    
    @IBAction func walletTapped (_ sender: UIButton) {
    }
    
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
        performSegue(withIdentifier: "PaymentViewControllerSegueFromCredit", sender: self)
    }
    
}
