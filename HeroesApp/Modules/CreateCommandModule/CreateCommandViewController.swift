//
//  CreateCommandViewController.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit

class CreateCommandViewController: UIViewController {
    
    var heroesTableView: UITableView!
    var presenter: CreateCommandPresenterProtocol!
    let commandCellIdentifier = "commandCellIdentifier"
    let commandHeaderCellIdentifier = "commandHeaderCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create new command"
        heroesTableView = UITableView()
        heroesTableView.register(CreateCommandTableViewCell.self, forCellReuseIdentifier: commandCellIdentifier)
        heroesTableView.register(CreateCommandHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: commandHeaderCellIdentifier)
        heroesTableView.delegate = self
        heroesTableView.dataSource = self
        heroesTableView.backgroundColor = .systemGray6
        heroesTableView.separatorStyle = .none
        configureSubViews()
        presenter.testCoreData()
    }
    
    
    func configureSubViews() {
        self.view.addSubview(heroesTableView)
        heroesTableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
    
}

//MARK: Extentions
extension CreateCommandViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 1
        case 3: return 1
        default: return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 || section == 3 {
            return 10
        } else {
            return 48
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroesTableView.dequeueReusableCell(withIdentifier: commandCellIdentifier, for: indexPath) as! CreateCommandTableViewCell
        cell.configure(indexPath: indexPath)
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: commandHeaderCellIdentifier) as! CreateCommandHeaderTableViewCell
        header.configure(section: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CreateCommandTableViewCell
        switch indexPath {
        case [0,0]: alertForCellName(label: cell.nameCellLabel, name: "Name", placeholder: "Enter name")

        default: print("none")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

extension CreateCommandViewController: CreateCommandViewProtocol {
    func receiveAlertInformation(title: String, message: String) {
        alertInformation(title: title, message: message)
    }
}


extension CreateCommandViewController: CreateCommandTableViewCellDelegate {
    func didTapCreateHeroButton(_ cell: CreateCommandTableViewCell) {
        presenter.createNewHeroDidTapped()
    }
    
    func didTapCreateButton(_ cell: CreateCommandTableViewCell) {
        presenter.createCommand()
    }
}
