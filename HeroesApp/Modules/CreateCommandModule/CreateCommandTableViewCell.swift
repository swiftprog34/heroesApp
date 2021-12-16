//
//  CreateCommandTableViewCell.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 15.12.2021.
//

import UIKit
import SnapKit

protocol CreateCommandTableViewCellDelegate: AnyObject {
    func didTapCreateButton(_ cell: CreateCommandTableViewCell)
    func didTapCreateHeroButton(_ cell: CreateCommandTableViewCell)
}

class CreateCommandTableViewCell: UITableViewCell {
    
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
    
    let addNewHeroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new hero", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let commandCreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create command", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    let creatingItemsArray = [
        ["Name"],
        ["One", "Two", "Three"],
        [""],
        [""]]
    
    weak var delegate: CreateCommandTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        commandCreateButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        addNewHeroButton.addTarget(self, action: #selector(didTapAddHero), for: .touchUpInside)
    }
    
    @objc func didTapCreate() {
        delegate?.didTapCreateButton(self)
    }
    
    @objc func didTapAddHero() {
        delegate?.didTapCreateHeroButton(self)
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
        
        self.addSubview(addNewHeroButton)
        addNewHeroButton.snp.makeConstraints { make in
            make.right.equalTo(backgroundViewCell.snp.right).offset(0)
            make.top.equalTo(backgroundViewCell.snp.top).offset(5)
            make.bottom.equalTo(backgroundViewCell.snp.bottom).offset(-5)
            make.left.equalTo(backgroundViewCell.snp.left).offset(0)
        }
        
        self.addSubview(commandCreateButton)
        commandCreateButton.snp.makeConstraints { make in
            make.right.equalTo(backgroundViewCell.snp.right).offset(-0)
            make.top.equalTo(backgroundViewCell.snp.top).offset(5)
            make.bottom.equalTo(backgroundViewCell.snp.bottom).offset(-5)
            make.left.equalTo(backgroundViewCell.snp.left).offset(0)
        }
    }
    
    func configure(indexPath: IndexPath) {
        nameCellLabel.text = creatingItemsArray[indexPath.section][indexPath.row]
        
        if indexPath == [2,0] {
            addNewHeroButton.isHidden = false
            backgroundViewCell.backgroundColor = .none
        }
        
        if indexPath == [3,0] {
            commandCreateButton.isHidden = false
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
