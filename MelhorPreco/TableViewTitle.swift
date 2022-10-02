//
//  TableViewTitle.swift
//  MelhorPreco
//
//  Created by user on 01/10/22.
//

import UIKit

class TableViewTitle : UITableViewCell {
    
    static let identifier : String = "TableViewTitle"
       
    
    var title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.90, green: 0.62, blue: 0.06, alpha: 1.00)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = .blue
        self.contentView.addSubview(title)
        self.backgroundColor = .white
        
        configTitle()
    }
    
    func configTitle(){
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
