//
//  CreateHeroTableViewCell.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 14.12.2021.
//

import UIKit
import SnapKit

protocol CreateHeroTableViewCellDelegate: AnyObject {
    func didTapGenerateButton(_ cell: CreateHeroTableViewCell)
    func didTapCreateButton(_ cell: CreateHeroTableViewCell)
}

class CreateHeroTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let heroAvatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .white
        imageView.isHidden = true
        return imageView
    }()
    
    let heroCreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let heroGenerateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate", for: .normal)
        button.backgroundColor = .green
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let creatingItemsArray = [
        [""],
        ["Name", "Phrase"],
        ["Arms", "Head", "Chest", "Legs"],
        [""]]
    
    weak var delegate: CreateHeroTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        heroGenerateButton.addTarget(self, action: #selector(didTapGenerate), for: .touchUpInside)
        heroCreateButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
    }
    
    @objc func didTapGenerate() {
        delegate?.didTapGenerateButton(self)
    }
    
    @objc func didTapCreate() {
        delegate?.didTapCreateButton(self)
    }

    
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        backgroundViewCell.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(0)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
            maker.bottom.equalToSuperview().offset(-1)
        }
        
        self.addSubview(nameCellLabel)
        nameCellLabel.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalTo(backgroundViewCell.snp.leading).offset(15)
        }
        
        self.addSubview(heroAvatarImageView)
        heroAvatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(backgroundViewCell.snp.left).offset(0)
        }
        
        self.addSubview(heroCreateButton)
        self.addSubview(heroGenerateButton)
        
        heroCreateButton.snp.makeConstraints { make in
            make.left.equalTo(backgroundViewCell.snp.left).offset(0)
            make.top.equalTo(backgroundViewCell.snp.top).offset(5)
            make.bottom.equalTo(backgroundViewCell.snp.bottom).offset(-5)
            make.right.equalTo(backgroundViewCell.snp.centerX).offset(-15)
        }

        heroGenerateButton.snp.makeConstraints { make in
            make.right.equalTo(backgroundViewCell.snp.right).offset(-0)
            make.top.equalTo(backgroundViewCell.snp.top).offset(5)
            make.bottom.equalTo(backgroundViewCell.snp.bottom).offset(-5)
            make.left.equalTo(backgroundViewCell.snp.centerX).offset(15)
        }
    }
    
    func configure(indexPath: IndexPath) {
        nameCellLabel.text = creatingItemsArray[indexPath.section][indexPath.row]
        
        if indexPath == [0,0] {
            heroAvatarImageView.isHidden = false
            backgroundViewCell.backgroundColor = .none
        }
        
        if indexPath == [3,0] {
            heroCreateButton.isHidden = false
            heroGenerateButton.isHidden = false
            backgroundViewCell.backgroundColor = .none
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
