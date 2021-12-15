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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 5
        case 3: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == [1,0] {
            return 100
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identificator, for: indexPath) as! CreateHeroTableViewCell
        cell.configure(indexPath: indexPath)
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
        case [0,0]: alertForCellName(label: cell.nameCellLabel, name: "Name", placeholder: "Enter name")
        case [0,1]: alertForCellName(label: cell.nameCellLabel, name: "Phrase", placeholder: "Enter phrase")
        case [1,0]: tapOnAvatar()
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

}

extension CreateHeroTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as! CreateHeroTableViewCell
            cell.heroAvatarImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}
