



import UIKit

class CreditCardViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var cardHolderFullName: UITextField!
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardExpirationDate: UITextField!
    @IBOutlet weak var cardCVV: UITextField!
    
    // VIEW DID LOAD
    override func viewDidLoad() {
       super.viewDidLoad()
        
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
    @IBAction func creditTapped (_ sender: UIButton) {
    }
    
    @IBAction func paypalTapped (_ sender: UIButton) {
    }
    
    @IBAction func walletTapped (_ sender: UIButton) {
        Alert.showBasicAlert(vc: self, title: "Feature not available yet", message: "Press OK to continue")
    }
    
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            let number = cardNumber.text
            let last2 = String(number!.suffix(2))
            controller.logo = "Mastercard"
            controller.holder = cardHolderFullName.text
            controller.information = "Master Card ending **\(last2)"
            present(controller, animated: true, completion: nil)
        }
    }
}
