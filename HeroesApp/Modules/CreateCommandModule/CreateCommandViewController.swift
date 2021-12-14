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

    
    var commandNameTextField: UILabel = {
        let label = UILabel()
        label.text = "Enter command name"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    
    var applyNewCommandButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create new command"
        self.view.backgroundColor = .systemBackground
        configureSubViews()
        applyNewCommandButton.addTarget(self, action: #selector(applyNewCommandButtonDidTapped), for: .touchUpInside)
        let gestureCommandName = UITapGestureRecognizer(target: self, action: #selector(tapOnCommandNameLabel(_ :)))
        commandNameTextField.addGestureRecognizer(gestureCommandName)
    }
    
    @objc func tapOnCommandNameLabel(_ sender: UITapGestureRecognizer) {
        let alertName = UIAlertController(title: "Enter command name", message: nil, preferredStyle: .alert)
        alertName.addTextField { textField in
            textField.placeholder = "Enter the name"
        }
        let actionOk = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertName.textFields?.first?.text {
                if !text.isEmpty {
                    self.commandNameTextField.text = text.capitalized
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertName.addAction(actionOk)
        alertName.addAction(actionCancel)
        present(alertName, animated: true, completion: nil)
    }
    
    func configureSubViews() {
        self.view.addSubview(commandNameTextField)
        commandNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }
        
        heroesTableView = UITableView()
        heroesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Hero")
        heroesTableView.delegate = self
        heroesTableView.dataSource = self
        self.view.addSubview(heroesTableView)
        heroesTableView.snp.makeConstraints { make in
            make.top.equalTo(commandNameTextField.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        self.view.addSubview(applyNewCommandButton)
        applyNewCommandButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-46)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }
        
    }
    
    @objc
    func applyNewCommandButtonDidTapped(){
        if let text = commandNameTextField.text {
            title = "Command: \(text)"
        }
    }
    
}

//MARK: Table view
extension CreateCommandViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroesTableView.dequeueReusableCell(withIdentifier: "Hero", for: indexPath)
        
        
        if indexPath.row == 2 {
            let addBtn = UIButton()
            addBtn.setTitle("Add hero", for: .normal)
            addBtn.setTitleColor(.blue, for: .normal)
            addBtn.setImage(.add, for: .normal)
            cell.contentView.addSubview(addBtn)
            addBtn.snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }
            addBtn.addTarget(self, action: #selector(createNewHeroDidTapped), for: .touchUpInside)
        } else {
            cell.textLabel?.text = String(indexPath.row)
        }
        
        return cell
    }
    
    @objc
    func createNewHeroDidTapped() {
        presenter.createNewHeroDidTapped()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Current \(indexPath.row)")
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

//MARK: Create command view protocol
extension CreateCommandViewController: CreateCommandViewProtocol {
    
}
