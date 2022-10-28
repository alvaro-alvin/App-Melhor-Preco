//
//  tableViewLista.swift
//  MelhorPreco
//
//  Created by user on 28/10/22.
//

import Foundation
import UIKit

class TableViewLista : UITableViewCell {
    
    static let identifier : String = "TableViewLista"
        
    
    var labelProduto : UILabel = {
        let produto = UILabel()
        produto.translatesAutoresizingMaskIntoConstraints = false
        return produto
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear

        self.contentView.addSubview(labelProduto)

        configLabelProduto()
        
    }
    

    
    func configLabelProduto(){
        NSLayoutConstraint.activate([
            labelProduto.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelProduto.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelProduto.topAnchor.constraint(equalTo: topAnchor),
            labelProduto.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
