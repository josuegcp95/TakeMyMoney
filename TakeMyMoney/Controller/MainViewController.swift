



import UIKit

class MainViewController: UIViewController {
    
    // OUTLETS 
    @IBOutlet weak var creditView: CreditView!
    @IBOutlet weak var paypalView: PaypalView!
    
    @IBOutlet weak var creditStackView: UIStackView!
    @IBOutlet weak var paypalStackView: UIStackView!
    
    let datePicker = UIDatePicker()
    
    var creditUser: PaymentDetails?
    var paypalUser: PaymentDetails?

    var creditSelected: Bool = true {
        didSet {
            creditView.isHidden = !creditSelected
            paypalView.isHidden = creditSelected
        }
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        createDatePicker()
        creditSelected = true
        creditView.invalidCardNumber.text = ""
        creditView.invalidExpiration.text = ""
        creditView.invalidCVV.text = ""
        creditView.invalidName.text = ""
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    // KEYBOARD
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if creditSelected == true {
        self.view.frame.origin.y = -30
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        if creditSelected == true {
        self.view.frame.origin.y = 0
        }
    }
    
    // DATE PICKER
    func createDatePicker () {
        // Tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        // Assign date picker
        creditView.cardExpirationDate.inputView = datePicker
        // Assign tool bar
        creditView.cardExpirationDate.inputAccessoryView = toolbar
        // Date alignment
        creditView.cardExpirationDate.textAlignment = .center
        // Date picker mode
        datePicker.datePickerMode = .date
        // Date picker style
        datePicker.preferredDatePickerStyle = .inline
    }
    
    // DONE BUTTON AND DATE FORMATTER
    @objc func donePressed () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MM/yyyy"
        creditView.cardExpirationDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
  
    // PAYMENT BUTTONS
    @IBAction func creditTapped (_ sender: UIButton) {
        creditSelected = true
    }
    @IBAction func paypalTapped (_ sender: UIButton) {
        creditSelected = false
        self.paypalStackView.frame.origin.y = 0
    }
    @IBAction func walletTapped (_ sender: UIButton) {
        Alert.showBasicAlert(vc: self, title: "Feature not available yet", message: "Press OK to continue")
    }
    
    // PROCEED BUTTON
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
        
        if creditSelected == true {
            
            do {
                try   creditCardValidation()
                
            } catch CardError.incompleteField {
                Alert.showBasicAlert(vc: self, title: "Incomplete Fields", message: "Please fill out every field")
                
            } catch CardError.incorrectCardNumberLenght {
                creditView.invalidCardNumber.text = "Invalid Card Number"
                
            } catch CardError.wrongExperitationDateFieldFormat {
                creditView.invalidExpiration.text = "Invalid Expiration"
                
            } catch CardError.incorrectCardCVVLenght {
                creditView.invalidCVV.text = "Invalid CVV"
                
            } catch CardError.incorrectCardHolderName {
                creditView.invalidName.text = "Invalid Name"
                
            } catch {
                Alert.showBasicAlert(vc: self, title: "Unable To Proceed", message: "There was an error when attempting to proceed")
            }

        } else if creditSelected == false {
            
            do {
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
    }
    
    // CREDIT CARD VALIDATION
    func creditCardValidation() throws {
        
        let last2 = String(creditView.cardNumber.text!.suffix(2))
        creditUser = PaymentDetails(logo: "Mastercard", holder: creditView.cardHolderFullName.text!, details: "Master Card ending **\(last2)")
        
        let number = creditView.cardNumber.text!
        let expiration = creditView.cardExpirationDate.text!
        let code = creditView.cardCVV.text!
        let name = creditView.cardHolderFullName.text!
        
        if number.isEmpty || expiration.isEmpty || code.isEmpty || name.isEmpty {
            throw CardError.incompleteField
        }
        
        if number.count != 16 {
            throw CardError.incorrectCardNumberLenght
        }
        
        if expiration.count != 7 {
            throw CardError.wrongExperitationDateFieldFormat
        }
        
        if code.count != 3 {
            throw CardError.incorrectCardCVVLenght
        }
        
        if !name.contains(" ") || name.doStringContainsNumber {
            throw CardError.incorrectCardHolderName
        }
        
        // Transitions to next screen
        if let controller = storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            controller.currentUser = self.creditUser
            present(controller, animated: true, completion: nil)
        }
    }
    
    // PAYPAL VALIDATION
    func paypalValidation() throws {
        
        paypalUser = PaymentDetails(logo: "Paypal", holder: "Paypal Credidentials", details: paypalView.paypalUsername.text!)
        
        let email = paypalView.paypalUsername.text!
        let password = paypalView.paypalPassword.text!
        
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
            controller.currentUser = self.paypalUser
            present(controller, animated: true, completion: nil)
        }
    }
}
