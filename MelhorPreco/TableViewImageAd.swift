//
//  TableViewImageAd.swift
//  MelhorPreco
//
//  Created by user on 28/09/22.
//


import UIKit

class TableViewImageAd : UITableViewCell {
    
    static let identifier : String = "TableViewImageAd"
       
    
    var imageViewAd : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "oferta_1")
        return image
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = .blue
        self.contentView.addSubview(imageViewAd)
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        configImageView()
    }
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewAd.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageViewAd.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageViewAd.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageViewAd.heightAnchor.constraint(equalToConstant: 174)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

