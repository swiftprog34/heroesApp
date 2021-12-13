//
//  ShowCommandsViewController.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit

class ShowCommandsViewController: UIViewController {

    var commandsTableView: UITableView!
    var presenter: ShowCommandsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List of commands"
        configureSubViews()
    }

    func configureSubViews(){
        commandsTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        commandsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Command")
        commandsTableView.delegate = self
        commandsTableView.dataSource = self
        self.view.addSubview(commandsTableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(createNewCommandDidTapped))
    }
    
    @objc
    func createNewCommandDidTapped(){
        presenter.goToCreateNewCommand()
    }
}

//MARK: Table view
extension ShowCommandsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commandsTableView.dequeueReusableCell(withIdentifier: "Command", for: indexPath)
        cell.textLabel?.text = "1"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Current \(indexPath.row)")
    }
}

//MARK: Show commands view protocol
extension ShowCommandsViewController: ShowCommandsViewProtocol {
    
}
