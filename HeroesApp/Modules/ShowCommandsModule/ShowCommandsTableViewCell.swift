//
//  ShowCommandsTableViewCell.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 15.12.2021.
//

import UIKit
import SnapKit

class ShowCommandsTableViewCell: UITableViewCell {
    
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
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

    }
    
    func configure(text: String) {
        nameCellLabel.text = text
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
