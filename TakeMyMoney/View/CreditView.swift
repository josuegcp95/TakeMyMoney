



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
    
    // DATE PICKER
    func createDatePicker () {
        // Tool bar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        // Assign date picker
        cardExpirationDate.inputView = datePicker
        // Assign tool bar
        cardExpirationDate.inputAccessoryView = toolbar
        // Date alignment
        cardExpirationDate.textAlignment = .center
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
        cardExpirationDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    // PROCEED BUTTON
    @IBAction func proceedToConfirmTapped (_ sender: UIButton) {
       
        do {
            // Transitions to next screen
            try creditCardValidation()

        } catch CardError.incompleteField {
            Alert.showBasicAlert(vc: self, title: "Incomplete Fields", message: "Please fill out every field")
            
        } catch CardError.incorrectCardNumberLenght {
            invalidCardNumber.text = "Invalid Card Number"
            
        } catch CardError.wrongExperitationDateFieldFormat {
            invalidExpiration.text = "Invalid Expiration"
            
        } catch CardError.incorrectCardCVVLenght {
            invalidCVV.text = "Invalid CVV"
            
        } catch CardError.incorrectCardHolderName {
            invalidName.text = "Invalid Name"
            
        } catch {
            Alert.showBasicAlert(vc: self, title: "Unable To Proceed", message: "There was an error when attempting to proceed")
        }
    }
    
    // CREDIT CARD VALIDATION
    func creditCardValidation() throws {
        
        let number = cardNumber.text!
        let expiration = cardExpirationDate.text!
        let code = cardCVV.text!
        let name = cardHolderFullName.text!
        
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
            let number = cardNumber.text
            let last2 = String(number!.suffix(2))
            controller.logo = "Mastercard"
            controller.holder = cardHolderFullName.text
            controller.information = "Master Card ending **\(last2)"
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
}
