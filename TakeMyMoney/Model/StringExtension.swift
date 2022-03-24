



import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var doStringContainsNumber: Bool {
        let numberRegEx  = ".*[0-9]+.*"
        let numberPredicate = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberPredicate.evaluate(with: self)
    }
}
