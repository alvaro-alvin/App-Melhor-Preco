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
    
    // objeto do produto
    var produto: ProdutoModel?
    
    // delegate que ira receber a view superior
    weak var delegate: ProductsViewCellDelegate?
    
    // contexto do coreData
    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // flag que identifica se é um produto
    var isProduto = true
    
    // User defaults
    let defaults = UserDefaults.standard
    
    // texto editavel do produto
    var textProduto : UITextField = {
        let produto = UITextField()
        produto.translatesAutoresizingMaskIntoConstraints = false
        return produto
    }()
    
    // prefixo
    var prefix : UILabel = {
        let prefix = UILabel()
        prefix.translatesAutoresizingMaskIntoConstraints = false
        prefix.text = "• "
        return prefix
    }()
    
    // funcao de deletar o produto
    @objc func deleteButtonClicked(sender: UIButton) {
        
        if sender == delete {
            produto?.removeFromListas((delegate?.getLista())!)
            delegate?.deleteCell(for: self)
        }
    }
    
    // botão de deletar
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
        // configura view
        self.backgroundColor = .clear
        
        // configura produto
        textProduto.delegate = self
        
        // adiciona elementos
        self.contentView.addSubview(prefix)
        self.contentView.addSubview(textProduto)
        self.contentView.addSubview(delete)
        
        // configura elementos
        configPrefix()
        configLabelProduto()
        configButton()
        
    }
    // função auxiliar
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

// botão para adicionar produto (função de botão é feira por meio da seleção da celular na tabela)
class AddProductButton : UITableViewCell{
    
    // label "+ Adicionar produto"
    var button : UILabel = {
        let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.text = "+ Adicionar produto"
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // configura view
        self.backgroundColor = .clear
        
        // adiciona elemento
        self.contentView.addSubview(button)
        
        // configura elemento
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

