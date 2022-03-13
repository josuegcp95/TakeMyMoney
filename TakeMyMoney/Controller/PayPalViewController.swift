



import UIKit

class PayPalViewController: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var paypalUsername: UITextField!
    @IBOutlet weak var paypalPassword: UITextField!
    
    // ERROR ENUMERATION
    enum LoginError: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
    }

    // VIEW DID LOAD
    override func viewDidLoad() {
       super.viewDidLoad()
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
    
    // PROCEED BUTTON
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
     
        do {
            // Transitions to next screen
            try paypalValidation()

        } catch LoginError.incompleteForm {
            Alert.showBasicAlert(vc: self, title: "Incomplete Form", message: "Please fill out both email and password fields")
            
        } catch LoginError.invalidEmail {
            Alert.showBasicAlert(vc: self, title: "Invalid Email Format", message: "Please make sure you format your email correctly")
            
        } catch LoginError.incorrectPasswordLength {
            Alert.showBasicAlert(vc: self, title: "Password Too Short", message: "Password should be at least 8 characters")
            
        } catch {
            Alert.showBasicAlert(vc: self, title: "Unable To Login", message: "There was an error when attempting to login")
        }
    }
    
    // PAYPAL VALIDATION
    func paypalValidation() throws {
        
        let email = paypalUsername.text!
        let password = paypalPassword.text!
        
        if email.isEmpty || password.isEmpty {
            throw LoginError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginError.invalidEmail
        }
        
        if password.count < 8 {
            throw LoginError.incorrectPasswordLength
        }
        // Transitions to next screen
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            controller.logo = "Paypal"
            controller.holder = "Paypal"
            controller.information = paypalUsername.text
            present(controller, animated: true, completion: nil)
        }
    }
}
