//
//  Router.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assembler: AssemblerProtocol? { get set }
    
    func initialViewController()
    func showCreateCommandModule()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assembler: AssemblerProtocol?
    
    init(navigationController: UINavigationController, assembler: AssemblerProtocol) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController  = assembler?.makeMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showCreateCommandModule() {
        if let navigationController = navigationController {
            guard let createCommandViewController  = assembler?.makeCreateCommandModule(router: self) else { return }
            navigationController.pushViewController(createCommandViewController, animated: true)
        }
    }
}
