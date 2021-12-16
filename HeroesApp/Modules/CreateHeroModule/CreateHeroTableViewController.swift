//
//  CreateHeroViewController.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit
import SnapKit

class CreateHeroTableViewController: UITableViewController {
    
    var presenter: CreateHeroPresenterProtocol!
    let avatarPicker = UIImagePickerController()
    let identificator = "idHeroCreateCell"
    let identificatorHeader = "idHeroCreateHeaderCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create new hero"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.register(CreateHeroTableViewCell.self, forCellReuseIdentifier: identificator)
        tableView.register(CreateHeroHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: identificatorHeader)
        avatarPicker.delegate = self
        presenter.testCoreData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        case 2: return 4
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == [0,0] {
            return 100
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificator, for: indexPath) as! CreateHeroTableViewCell
        cell.configure(indexPath: indexPath)
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identificatorHeader) as! CreateHeroHeaderTableViewCell
        header.configure(section: section)
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            return 10
        } else {
            return 48
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CreateHeroTableViewCell
        switch indexPath {
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Name", placeholder: "Enter name")
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Phrase", placeholder: "Enter phrase")
        case [2,0]: alertEquipmentItems(label: cell.nameCellLabel, name: "Choose arms item", items: EquipmentData.arms)
        case [2,1]: alertEquipmentItems(label: cell.nameCellLabel, name: "Choose head item", items: EquipmentData.head)
        case [2,2]: alertEquipmentItems(label: cell.nameCellLabel, name: "Choose chest item", items: EquipmentData.chest)
        case [2,3]: alertEquipmentItems(label: cell.nameCellLabel, name: "Choose legs item", items: EquipmentData.legs)
        case [0,0]: tapOnAvatar()
        default: print("none")
        }
    }
    
    func tapOnAvatar() {
        let alertPicker = UIAlertController(title: "Choose image", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "Photogallery", style: .default) { alert in
            self.avatarPicker.sourceType = .photoLibrary
            self.avatarPicker.allowsEditing = true
            self.present(self.avatarPicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { alert in
            self.avatarPicker.sourceType = .camera
            self.avatarPicker.allowsEditing = true
            self.present(self.avatarPicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertPicker.addAction(actionPhoto)
        alertPicker.addAction(actionCamera)
        alertPicker.addAction(actionCancel)
        present(alertPicker, animated: true, completion: nil)
    }
}

//MARK: Extentions
extension CreateHeroTableViewController: CreateHeroViewProtocol {
    
    func successGenerate(data: Hero, title: String, message: String) {
        DispatchQueue.main.async {
            
            let url = URL(string: data.results[0].picture.thumbnail)
            if let url = url {
                let imageCell = self.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! CreateHeroTableViewCell
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    imageCell.heroAvatarImageView.image = image
                }
            }
            
            
            let nameCell = self.tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as! CreateHeroTableViewCell
            nameCell.nameCellLabel.text = data.results[0].name.first + data.results[0].name.last
            
            let phraseCell = self.tableView.cellForRow(at: IndexPath(item: 1, section: 1)) as! CreateHeroTableViewCell
            phraseCell.nameCellLabel.text = "Hello, i'm from \(data.results[0].location.city)"
            
            let armsCell = self.tableView.cellForRow(at: IndexPath(item: 0, section: 2)) as! CreateHeroTableViewCell
            armsCell.nameCellLabel.text = EquipmentData.arms.randomElement()
            
            let headCell = self.tableView.cellForRow(at: IndexPath(item: 1, section: 2)) as! CreateHeroTableViewCell
            headCell.nameCellLabel.text = EquipmentData.head.randomElement()
            
            let chestCell = self.tableView.cellForRow(at: IndexPath(item: 2, section: 2)) as! CreateHeroTableViewCell
            chestCell.nameCellLabel.text = EquipmentData.chest.randomElement()
            
            let legsCell = self.tableView.cellForRow(at: IndexPath(item: 3, section: 2)) as! CreateHeroTableViewCell
            legsCell.nameCellLabel.text = EquipmentData.legs.randomElement()
        }
        
        alertInformation(title: title, message: message)
    }
  
    func receiveAlertInformation(title: String, message: String) {
        alertInformation(title: title, message: message)
    }
}

extension CreateHeroTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! CreateHeroTableViewCell
            cell.heroAvatarImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateHeroTableViewController: CreateHeroTableViewCellDelegate {
    func didTapCreateButton(_ cell: CreateHeroTableViewCell) {
        presenter.createHero()
    }
    
    func didTapGenerateButton(_ cell: CreateHeroTableViewCell) {
        presenter.generateHero()
    }
}
