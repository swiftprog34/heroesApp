//
//  CreateCommandViewController.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit

class CreateCommandViewController: UIViewController {

    var presenter: CreateCommandPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create new command"
        self.view.backgroundColor = .blue
    }

}

//MARK: Create command view protocol
extension CreateCommandViewController: CreateCommandViewProtocol {
    
}
