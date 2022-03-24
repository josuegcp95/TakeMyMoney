



import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var creditView: CreditView!
    @IBOutlet weak var paypalView: PaypalView!
    
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        createDatePicker()
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



}
