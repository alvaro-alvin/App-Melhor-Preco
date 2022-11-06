//
//  tableViewListEdit.swift
//  MelhorPreco
//
//  Created by user on 06/11/22.
//


import Foundation
import UIKit

class TableViewListEdit : UITableViewCell, UITextFieldDelegate{
    
    static let identifier : String = "TableViewListEdit"
        
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
        do{
        var listaAtual = try JSONDecoder().decode(Lista.self, from: defaults.data(forKey: "listaAtual")!)
            listaAtual.produtos[index] = textField.text!
            print(listaAtual)
            
            let data = try JSONEncoder().encode(listaAtual)
            // Write/Set Data
            defaults.set(data, forKey: "listaAtual")
        }
        catch{
            print("Erro ao extrair lista atual de defaults (\(error)))")
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

