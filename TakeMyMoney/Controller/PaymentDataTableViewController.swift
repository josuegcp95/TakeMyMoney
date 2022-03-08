



import UIKit

class PaymentDataTableViewController: UITableViewController {

    // OUTLETS
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardExpirationDate: UITextField!
    @IBOutlet weak var cardCVV: UITextField!
    @IBOutlet weak var cardHolderFullName: UITextField!
    @IBOutlet weak var paypalUsername: UITextField!
    @IBOutlet weak var paypalPassword: UITextField!
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
    // DESELECT ROWS
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // PAYMENT METHOD CHANGE
    @IBAction func paymentMethodChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print ("Credit")
        case 1:
            print ("Paypal")
        case 2:
            print ("Wallet")
        default:
            break
        }
        
    }
    
    
}
