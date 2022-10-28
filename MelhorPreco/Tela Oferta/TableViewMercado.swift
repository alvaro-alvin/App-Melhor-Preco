//
//  TableViewMercado.swift
//  MelhorPreco
//
//  Created by user on 14/10/22.
//

import UIKit

class TableViewMercado : UITableViewCell {
    
    static let identifier : String = "TableViewMercado"

    var celulaEsquerda : UIView = {
        let celula = UIView()
        celula.translatesAutoresizingMaskIntoConstraints = false
        //celula.backgroundColor = .blue
        return celula
    }()

    var celulaDireita : UIView = {
        let celula = UIView()
        celula.translatesAutoresizingMaskIntoConstraints = false
        //celula.backgroundColor = .red
        return celula
    }()


    var imageViewProduto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.backgroundColor = .lightGray
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()

    var labelNome : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "             "
        nome.font = UIFont.systemFont(ofSize: 14)
        nome.textColor = .darkGray
        //nome.backgroundColor = .lightGray
        
        return nome
    }()

    var textPreco : UILabel = {
        let preco = UILabel()
        preco.translatesAutoresizingMaskIntoConstraints = false
        preco.text = "       "
        
        
        //preco.backgroundColor = .lightGray
        
        return preco
    }()


    var textAbaixoDaMedia : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = ""
        nome.textColor = .darkGray
        nome.contentMode = .center
        nome.textAlignment = .center
        nome.adjustsFontSizeToFitWidth = true
        nome.font = UIFont.systemFont(ofSize: 11)
        nome.numberOfLines = 2
        
        return nome
    }()


    var labelPorcentagem : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "    "
        //nome.backgroundColor = .lightGray
        nome.textColor = .darkGray
        nome.font = UIFont.systemFont(ofSize: 18.0)
        return nome
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = .blue
        self.contentView.addSubview(celulaDireita)
        self.contentView.addSubview(celulaEsquerda)
        self.celulaEsquerda.addSubview(imageViewProduto)
        self.celulaEsquerda.addSubview(textPreco)
        self.celulaEsquerda.addSubview(labelNome)
        self.celulaDireita.addSubview(labelPorcentagem)
        self.celulaDireita.addSubview(textAbaixoDaMedia)
        configCelulaDireita()
        configCelulaEsquerda()
        configImageView()
        configTextPreco()
        configLabelNome()
        configLabelPorcentagem()
        configTextMedia()
        
    }



    func configCelulaDireita(){
        NSLayoutConstraint.activate([
            celulaDireita.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            celulaDireita.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),      celulaDireita.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (2/3*frame.width) + 10),
            celulaDireita.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func configCelulaEsquerda(){
        NSLayoutConstraint.activate([
            celulaEsquerda.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            celulaEsquerda.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            celulaEsquerda.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            celulaEsquerda.trailingAnchor.constraint(equalTo: celulaDireita.leadingAnchor, constant: -10)
        ])
    }

    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewProduto.centerYAnchor.constraint(equalTo: celulaEsquerda.centerYAnchor),
            imageViewProduto.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor),
            imageViewProduto.trailingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor, constant: 55),
            imageViewProduto.heightAnchor.constraint(equalToConstant: 55),
            imageViewProduto.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configLabelNome(){
        NSLayoutConstraint.activate([
            labelNome.topAnchor.constraint(equalTo: celulaEsquerda.centerYAnchor),
            labelNome.bottomAnchor.constraint(equalTo: celulaEsquerda.bottomAnchor),
            labelNome.leadingAnchor.constraint(equalTo: imageViewProduto.trailingAnchor, constant: 10),
            labelNome.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor),
        ])
    }
    
    func configTextPreco(){
        NSLayoutConstraint.activate([
            
            textPreco.topAnchor.constraint(equalTo: celulaEsquerda.topAnchor, constant: 10),
            textPreco.bottomAnchor.constraint(equalTo: celulaEsquerda.centerYAnchor),
            textPreco.leadingAnchor.constraint(equalTo: imageViewProduto.trailingAnchor, constant: 10),
            textPreco.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor)
        ])
    }

    func configLabelPorcentagem(){
        NSLayoutConstraint.activate([
            labelPorcentagem.topAnchor.constraint(equalTo: celulaDireita.topAnchor, constant: 22),
            labelPorcentagem.centerXAnchor.constraint(equalTo: celulaDireita.centerXAnchor)
            
        ])
        
    }

    func configTextMedia(){
        NSLayoutConstraint.activate([
            textAbaixoDaMedia.topAnchor.constraint(equalTo: labelPorcentagem.bottomAnchor, constant: -10),
            textAbaixoDaMedia.bottomAnchor.constraint(equalTo: celulaDireita.bottomAnchor),
            textAbaixoDaMedia.leadingAnchor.constraint(equalTo: celulaDireita.leadingAnchor, constant: 22),
            textAbaixoDaMedia.trailingAnchor.constraint(equalTo: celulaDireita.trailingAnchor, constant: -22)
            
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
