



import UIKit

class PaymentViewController: UIViewController {
    
    // OUTLET
    @IBOutlet weak var paymentLogo: UIImageView!
    @IBOutlet weak var paymentHolder: UILabel!
    @IBOutlet weak var paymentInformation: UILabel!
    
    var logo: String?
    var holder: String?
    var information: String?
    
    // VIEW DID LOAD
    override func viewDidLoad() {
       super.viewDidLoad()
        
        if let logo = logo, let holder = holder, let information = information {
            paymentLogo.image = UIImage(named: logo)
            paymentHolder.text = holder
            paymentInformation.text = information
        }
        
        overrideUserInterfaceStyle = .light
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -175 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    // ACTIONS
    @IBAction func editTapped (_ sender: UIButton) {
    }
    
    @IBAction func payTapped (_ sender: UIButton) {
        Alert.showBasicAlert(on: self, with: "Payment failed", message: "Press OK to try again")
    }
    
}
