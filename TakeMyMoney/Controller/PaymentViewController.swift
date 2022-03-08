



import UIKit

class PaymentViewController: UIViewController {
    
    // OUTLET

    @IBOutlet weak var paymentLogo: UIImageView!
    @IBOutlet weak var paymentHolder: UILabel!
    @IBOutlet weak var paymentInformation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    
    // ACTIONS
    @IBAction func editTapped (_ sender: UIButton) {
    }
    
    @IBAction func payTapped (_ sender: UIButton) {
    }
    
}
