import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
