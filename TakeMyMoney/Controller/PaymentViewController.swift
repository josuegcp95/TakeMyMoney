



import UIKit

class PaymentViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var paymentLogo: UIImageView!
    @IBOutlet weak var paymentHolder: UILabel!
    @IBOutlet weak var paymentInformation: UILabel!
    
    var currentUser: PaymentDetails!
    
    // VIEW DID LOAD
    override func viewDidLoad() {
       super.viewDidLoad()

        paymentLogo.image = UIImage(named: currentUser.logo)
        paymentHolder.text = currentUser.holder
        paymentInformation.text = currentUser.details
        
        overrideUserInterfaceStyle = .light
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // KEYBOARD
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -225 // Move view 150 points upward
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }

    // ACTIONS
    @IBAction func editTapped (_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func payTapped (_ sender: UIButton) {
        Alert.showBasicAlert(vc: self, title: "Payment failed", message: "Press OK to try again")
    }
}
