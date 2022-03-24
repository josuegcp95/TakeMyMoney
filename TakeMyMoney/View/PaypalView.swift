



import UIKit

class PaypalView: UIView {
    @IBOutlet weak var paypalUsername: UITextField!
    @IBOutlet weak var paypalPassword: UITextField!
    
    
    
    
    
    // PROCEED BUTTON
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
        do {
            // Transitions to next screen
            try paypalValidation()

        } catch PaypalError.incompleteForm {
            Alert.showBasicAlert(vc: self, title: "Incomplete Form", message: "Please fill out both email and password fields")
            
        } catch PaypalError.invalidEmail {
            Alert.showBasicAlert(vc: self, title: "Invalid Email Format", message: "Please make sure you format your email correctly")
            
        } catch PaypalError.incorrectPasswordLength {
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
            throw PaypalError.incompleteForm
        }
        
        if !email.isValidEmail {
            throw PaypalError.invalidEmail
        }
        
        if password.count < 8 {
            throw PaypalError.incorrectPasswordLength
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
