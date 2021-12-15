//
//  UIViewExtentions.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 15.12.2021.
//

import UIKit

extension UIViewController {
    func alertForCellName(label: UILabel,name: String, placeholder: String) {
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { action in
            let alertTextField = alert.textFields?.first
            guard let text = alertTextField?.text else {return}
            label.text = text
        }
        
        alert.addTextField { text in
            text.placeholder = placeholder
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
}
