//
//  tableViewListShort.swift
//  MelhorPreco
//
//  Created by user on 07/12/22.
//

import UIKit
import CoreData

class TableViewListShort : UITableViewCell{
    
    static let identifier : String = "TableViewListShort"
    
    var listName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lista nao definida"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    var backGround : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.97, alpha: 1)
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true

        return view
    }()
    
    var checkMark : CheckRadio = {
        let check = CheckRadio()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.awakeFromNib()
        return check
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear

        self.contentView.addSubview(backGround)
        self.contentView.addSubview(listName)
        self.contentView.addSubview(checkMark)
        
        configBG()
        configListName()
        configCheckMark()
        
    }
    
    func configBG(){
        NSLayoutConstraint.activate([
            backGround.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backGround.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGround.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGround.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            backGround.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1)
        ])
    }
    
    func configListName(){
        NSLayoutConstraint.activate([
            listName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            listName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            listName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            listName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            listName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configCheckMark(){
        NSLayoutConstraint.activate([
            checkMark.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkMark.leadingAnchor.constraint(equalTo: listName.trailingAnchor, constant: 5),
            checkMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            checkMark.heightAnchor.constraint(equalToConstant: 30),
            checkMark.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class CheckRadio: UIButton {
    // Images
    let checkedImage = UIImage(systemName: "largecircle.fill.circle")!.withTintColor(UIColor(named: "appBlue")!) as UIImage
    let uncheckedImage = UIImage(systemName: "circle")!.withTintColor(UIColor(named: "appBlue")!) as UIImage
    // por algum motivo a cor nao é trocada
    
    //let checkedImage = UIImage(systemName: "largecircle.fill.circle")! as UIImage
    //let uncheckedImage = UIImage(systemName: "circle")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

