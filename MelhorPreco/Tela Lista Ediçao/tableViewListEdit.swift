//
//  tableViewListEdit.swift
//  MelhorPreco
//
//  Created by user on 06/11/22.
//


import Foundation
import UIKit
import CoreData

class TableViewListEdit : UITableViewCell, UITextFieldDelegate{
    
    static let identifier : String = "TableViewListEdit"
    
    var produto: ProdutoModel?
    
    var produtoName: String?

    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isProduto = true
        
    var index: Int = 0
    
    let defaults = UserDefaults.standard
    
    var textProduto : UITextField = {
        let produto = UITextField()
        produto.translatesAutoresizingMaskIntoConstraints = false
        return produto
    }()
    
    var prefix : UILabel = {
        let prefix = UILabel()
        prefix.translatesAutoresizingMaskIntoConstraints = false
        prefix.text = "• "
        return prefix
    }()
    
    // Atualiza os produtos da lista atual quando ele esta sendo editado
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isProduto){
            produto!.name = textField.text!
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        textProduto.delegate = self
        
        self.contentView.addSubview(prefix)
        self.contentView.addSubview(textProduto)
        
        configPrefix()
        configLabelProduto()
        
    }
    
    func autoConfigure(){
        textProduto.text = produto!.name
    }
    
    
    func configPrefix(){
        NSLayoutConstraint.activate([
            prefix.leadingAnchor.constraint(equalTo: leadingAnchor),
            prefix.widthAnchor.constraint(equalToConstant: 20),
            prefix.topAnchor.constraint(equalTo: topAnchor),
            prefix.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    func configLabelProduto(){
        NSLayoutConstraint.activate([
            textProduto.leadingAnchor.constraint(equalTo: prefix.trailingAnchor),
            textProduto.trailingAnchor.constraint(equalTo: trailingAnchor),
            textProduto.topAnchor.constraint(equalTo: topAnchor),
            textProduto.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

