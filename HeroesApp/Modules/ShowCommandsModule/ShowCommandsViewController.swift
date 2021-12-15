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
    let searchController = UISearchController()
    let commandCellIdentifier = "commandCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        title = "List of commands"
        
        commandsTableView = UITableView(frame: CGRect(), style: .grouped)
        commandsTableView.register(ShowCommandsTableViewCell.self, forCellReuseIdentifier: commandCellIdentifier)
        commandsTableView.delegate = self
        commandsTableView.dataSource = self
        commandsTableView.backgroundColor = .systemGray6
        commandsTableView.separatorStyle = .none
        configureSubViews()
    }

    func configureSubViews(){
        self.view.addSubview(commandsTableView)
        commandsTableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
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
        let cell = commandsTableView.dequeueReusableCell(withIdentifier: commandCellIdentifier, for: indexPath) as! ShowCommandsTableViewCell
        cell.configure(text: "1")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Current \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: Show commands view protocol
extension ShowCommandsViewController: ShowCommandsViewProtocol {
    
}
