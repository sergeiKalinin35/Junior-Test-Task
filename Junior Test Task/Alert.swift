//
//  Alert.swift
//  Junior Test Task
//
//  Created by Sergey on 06.09.2021.
//

import UIKit

extension UIViewController {
    // первый метод вызов алерт контроллера в который вводим наш адресс
    func alertAddAdress(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "✓", style: .default) { (action) in
        print("action")
        }
        
        let alertCancel = UIAlertAction(title: "♻︎", style: .default) { (_) in
            
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
}
