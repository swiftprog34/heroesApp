//
//  CreateHeroHeaderTableViewCell.swift
//  HeroesApp
//
//  Created by Виталий Емельянов on 14.12.2021.
//

import UIKit
import SnapKit

class CreateHeroHeaderTableViewCell: UITableViewHeaderFooterView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "HEADER"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let headersNameArray = ["ADD IMAGE", "CHOOSE BASE ITEMS", "ADD EQUIPMENT", ""]
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerLabel.textColor = .gray
        setConstraints()
        
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(15)
            maker.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(section: Int) {
        headerLabel.text = headersNameArray[section]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
