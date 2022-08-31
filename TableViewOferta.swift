//
//  TableViewOferta.swift
//  MelhorPreco
//
//  Created by user219712 on 8/29/22.
//

import UIKit

class TableViewOferta : UITableViewCell {
    
    static let identifier : String = "TableViewOferta"
    
    var imageViewProduto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        return image
    }()
    
    var labelNome : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "             "
        nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    var textPreco : UITextView = {
        let preco = UITextView()
        preco.translatesAutoresizingMaskIntoConstraints = false
        preco.text = "       "
        preco.backgroundColor = .lightGray
        
        return preco
    }()
    
    var textNomeEstabelecimento : UITextView = {
        let nome = UITextView()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "       "
        nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    var textAbaixoDaMedia : UITextView = {
        let nome = UITextView()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "Abaixo da média"
        nome.textColor = .green
        
        return nome
    }()
    
    
    var labelPorcentagem : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "    "
        nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .blue
        self.contentView.addSubview(imageViewProduto)
        self.contentView.addSubview(labelNome)
        self.contentView.addSubview(textPreco)
        self.contentView.addSubview(textNomeEstabelecimento)
        self.contentView.addSubview(labelPorcentagem)
        self.contentView.addSubview(textAbaixoDaMedia)
        configImageView()
        configLabelNome()
        configTextPreco()
        configTextEstabelecimento()
        configLabelPorcentagem()
        configTextMedia()
        
    }
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewProduto.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageViewProduto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
    func configLabelNome(){
        NSLayoutConstraint.activate([
            labelNome.topAnchor.constraint(equalTo: imageViewProduto.topAnchor),
            labelNome.leadingAnchor.constraint(equalTo: imageViewProduto.rightAnchor, constant: 10)
        ])
    }
    
    func configTextPreco(){
        NSLayoutConstraint.activate([
            textPreco.centerYAnchor.constraint(equalTo: imageViewProduto.centerYAnchor),
            textPreco.leadingAnchor.constraint(equalTo: imageViewProduto.rightAnchor, constant: 10)
        ])
        
    }
    
    func configTextEstabelecimento(){
        NSLayoutConstraint.activate([
            textNomeEstabelecimento.bottomAnchor.constraint(equalTo: imageViewProduto.bottomAnchor, constant: -10),
            textNomeEstabelecimento.leadingAnchor.constraint(equalTo: imageViewProduto.rightAnchor, constant: 10)
        ])
    }
    
    func configLabelPorcentagem(){
        NSLayoutConstraint.activate([
            labelPorcentagem.topAnchor.constraint(equalTo: imageViewProduto.topAnchor),
            labelPorcentagem.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
        
    }
    
    func configTextMedia(){
        NSLayoutConstraint.activate([
            textAbaixoDaMedia.bottomAnchor.constraint(equalTo: imageViewProduto.bottomAnchor),
            textAbaixoDaMedia.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
