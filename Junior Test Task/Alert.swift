//
//  Alert.swift
//  Junior Test Task
//
//  Created by Sergey on 06.09.2021.
//

import UIKit

extension UIViewController {
    // первый метод вызов алерт контроллера в который вводим наш адресс
    func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping(String) -> Void ) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "✓", style: .default) { (action) in
       // print("action")
            
         // текс из текст филда получаем
            let tfText = alertController.textFields?.first// опционал проверка и получаем через guard
            
            guard let text = tfText?.text else { return }
            
            
            
            
        }
        
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        
        
        
        
        
        
        
        let alertCancel = UIAlertAction(title: "♻︎", style: .default) { (_) in
            
        }
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
}
// создали алерт с кнопками теперь добавляем в него текстовое поле смотреть вверх
