//
//  CheckView.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CheckView: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var successView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboard()
        
        checkButton.layer.cornerRadius = 8
        
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7803921569, blue: 0.8, alpha: 1)
        contentTextView.text = ""
    }
    

    @IBAction func checkButtonTapped(_ sender: Any) {
        
        if (contentTextView.text == "") {
            let alertController = UIAlertController(title: "Ошибка", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
            
        } else {
            CheckNetworkService.postCheckContent(content: contentTextView.text) { (category) in
                print(category)
            }
        }
        
    }

    
    // Вызывается, когда пользователь кликает на view (за пределами textField)
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
