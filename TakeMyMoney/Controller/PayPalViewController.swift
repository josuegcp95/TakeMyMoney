



import UIKit

class PayPalViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var paypalUsername: UITextField!
    @IBOutlet weak var paypalPassword: UITextField!

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
        performSegue(withIdentifier: "PaymentViewControllerSegueFromPaypal", sender: self)
    }
    
}
