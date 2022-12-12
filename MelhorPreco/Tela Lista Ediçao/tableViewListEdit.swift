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
    
    weak var delegate: ProductsViewCellDelegate?

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
    
    @objc func deleteButtonClicked(sender: UIButton) {
        
        if sender == delete {
            managedContext.delete(produto!)
            delegate?.deleteCell(for: self)
        }
    }
    
    var delete : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(nil, action:#selector(deleteButtonClicked), for: .touchUpInside)
        
        return button
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
        self.contentView.addSubview(delete)
        
        configPrefix()
        configLabelProduto()
        configButton()
        
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
            textProduto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            textProduto.topAnchor.constraint(equalTo: topAnchor),
            textProduto.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    func configButton(){
        NSLayoutConstraint.activate([
            delete.widthAnchor.constraint(equalToConstant: 10),
            delete.leadingAnchor.constraint(equalTo: textProduto.trailingAnchor),
            delete.heightAnchor.constraint(equalToConstant: 10),
            delete.centerYAnchor.constraint(equalTo: textProduto.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class AddProductButton : UITableViewCell{
    
    
    var button : UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "+ Adicionar produto"
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear

        self.contentView.addSubview(button)
        
        configButton()
    }
    
    func configButton(){
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

