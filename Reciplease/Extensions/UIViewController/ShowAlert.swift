//
//  ShowAlert.swift
//  Reciplease
//
//  Created by Manon Russo on 26/05/2021.
//

import UIKit

extension UIViewController {
    /// This methods is creating a UIAlert.
    func showAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
