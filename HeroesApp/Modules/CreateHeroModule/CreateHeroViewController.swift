//
//  CreateHeroViewController.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 12.12.2021.
//

import UIKit
import SnapKit

class CreateHeroViewController: UIViewController {

    var presenter: CreateHeroPresenterProtocol!
    
    var heroNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter hero name"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var heroPhraseLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter hero phrase"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    
    var heroAvatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "add-avatar"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var applyNewHeroButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    let avatarPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create new hero"
        self.view.backgroundColor = .systemBackground
    
        avatarPicker.delegate = self
        configureSubviews()
        
        let gestureAvatar = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage(_ :)))
        heroAvatarImageView.addGestureRecognizer(gestureAvatar)
        let gestureName = UITapGestureRecognizer(target: self, action: #selector(tapOnNameLabel(_ :)))
        heroNameLabel.addGestureRecognizer(gestureName)
        let gesturePhrase = UITapGestureRecognizer(target: self, action: #selector(tapOnPhraseLabel(_ :)))
        heroPhraseLabel.addGestureRecognizer(gesturePhrase)
        
        applyNewHeroButton.addTarget(self, action: #selector(applyNewHeroButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func tapOnAvatarImage(_ sender: UITapGestureRecognizer) {
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
    
    @objc func tapOnPhraseLabel(_ sender: UITapGestureRecognizer) {
        let alertName = UIAlertController(title: "Enter hero phrase", message: nil, preferredStyle: .alert)
        alertName.addTextField { textField in
            textField.placeholder = "Enter the phrase"
        }
        let actionOk = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertName.textFields?.first?.text {
                if !text.isEmpty {
                    self.heroPhraseLabel.text = text.capitalized
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertName.addAction(actionOk)
        alertName.addAction(actionCancel)
        present(alertName, animated: true, completion: nil)
    }
    
    @objc func tapOnNameLabel(_ sender: UITapGestureRecognizer) {
        let alertName = UIAlertController(title: "Enter hero name", message: nil, preferredStyle: .alert)
        alertName.addTextField { textField in
            textField.placeholder = "Enter the name"
        }
        let actionOk = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertName.textFields?.first?.text {
                if !text.isEmpty {
                    self.heroNameLabel.text = text.capitalized
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertName.addAction(actionOk)
        alertName.addAction(actionCancel)
        present(alertName, animated: true, completion: nil)
    }
    
    func configureSubviews() {
        
        self.view.addSubview(heroNameLabel)
        heroNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }
        
        self.view.addSubview(heroPhraseLabel)
        heroPhraseLabel.snp.makeConstraints { make in
            make.top.equalTo(heroNameLabel.snp.bottom).offset(8)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }
        
        self.view.addSubview(heroAvatarImageView)
        heroAvatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.centerX.equalToSuperview()
            make.top.equalTo(heroPhraseLabel.snp.bottom).offset(8)
        }
        
        self.view.addSubview(applyNewHeroButton)
        applyNewHeroButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-46)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(8)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-8)
        }
    }
    
    @objc func applyNewHeroButtonDidTapped() {
        
    }

}

//MARK: Create hero view protocol
extension CreateHeroViewController: CreateHeroViewProtocol {
    
}

extension CreateHeroViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            heroAvatarImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
}

