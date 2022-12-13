//
//  TableViewOferta.swift
//  MelhorPreco
//
//  Created by user219712 on 8/29/22.
//

// Celula da tabela que contém as informações de cada oferta

import UIKit

class TableViewOferta : UITableViewCell {
    
    static let identifier : String = "TableViewOferta"
    
    // é dividida em duas celulas para facilitar a organização
    
    var celulaEsquerda : UIView = {
        let celula = UIView()
        celula.translatesAutoresizingMaskIntoConstraints = false
        //celula.backgroundColor = .white
        return celula
    }()
    
    var celulaDireita : UIView = {
        let celula = UIView()
        celula.translatesAutoresizingMaskIntoConstraints = false
        //celula.backgroundColor = .white
        return celula
    }()
    
    // imagem do produto
    var imageViewProduto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    // nome do produto
    var labelNome : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "             "
        //nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    // Preço do produto
    var textPreco : UILabel = {
        let preco = UILabel()
        preco.translatesAutoresizingMaskIntoConstraints = false
        preco.text = "       "
        preco.textColor = .darkGray
        preco.font = UIFont.systemFont(ofSize: 14)
        //preco.backgroundColor = .lightGray
        
        return preco
    }()
    
    // nome do estabelecimento
    var nomeEstabelecimento : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "       "
        nome.textColor = .lightGray
        nome.font = UIFont.systemFont(ofSize: 12)
        //nome.backgroundColor = .darkGray

        return nome
    }()
    
    // label "Abaixo da média"
    var labelAbaixoDaMedia : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = ""
        nome.textColor = UIColor(named: "verde_oferta")
        nome.contentMode = .center
        nome.textAlignment = .center
        nome.adjustsFontSizeToFitWidth = true
        nome.font = UIFont.systemFont(ofSize: 11)
        nome.numberOfLines = 2
        
        return nome
    }()
    
    // label da porcentagem
    var labelPorcentagem : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "    "
        //nome.backgroundColor = .lightGray
        nome.textColor = UIColor(named: "verde_oferta")
        nome.font = UIFont.boldSystemFont(ofSize: 18.0)
        return nome
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // configuração da view principal
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        // adicionando elementos
        self.contentView.addSubview(imageViewProduto)
        self.contentView.addSubview(celulaDireita)
        self.contentView.addSubview(celulaEsquerda)
        self.contentView.addSubview(labelNome)
        self.contentView.addSubview(nomeEstabelecimento)
        self.contentView.addSubview(textPreco)
        self.contentView.addSubview(labelPorcentagem)
        self.contentView.addSubview(labelAbaixoDaMedia)
        
        // configurando elementos
        configImageView()
        configCelulaDireita()
        configCelulaEsquerda()
        configLabelNome()
        configEstabelecimento()
        configTextPreco()
        configLabelPorcentagem()
        configLabelMedia()
        
    }
    
    func configCelulaEsquerda(){
        NSLayoutConstraint.activate([
            celulaEsquerda.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            celulaEsquerda.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            celulaEsquerda.leadingAnchor.constraint(equalTo: imageViewProduto.trailingAnchor, constant: 10),
            celulaEsquerda.trailingAnchor.constraint(equalTo: celulaDireita.leadingAnchor, constant: -10)
        ])
    }
    
    func configCelulaDireita(){
        NSLayoutConstraint.activate([
            celulaDireita.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            celulaDireita.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),      celulaDireita.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (2/3*frame.width) + 10),
            celulaDireita.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])    }
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewProduto.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageViewProduto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageViewProduto.heightAnchor.constraint(equalToConstant: 80),
            imageViewProduto.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configLabelNome(){
        NSLayoutConstraint.activate([
            labelNome.topAnchor.constraint(equalTo: celulaEsquerda.topAnchor),
            labelNome.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor)
        ])
    }
    
    func configTextPreco(){
        NSLayoutConstraint.activate([
            textPreco.topAnchor.constraint(equalTo: labelNome.bottomAnchor),
            textPreco.bottomAnchor.constraint(equalTo: nomeEstabelecimento.topAnchor),
            textPreco.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor),
            textPreco.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor)

        ])
        
    }
    
    func configEstabelecimento(){
        NSLayoutConstraint.activate([
            nomeEstabelecimento.bottomAnchor.constraint(equalTo: celulaEsquerda.bottomAnchor),
            nomeEstabelecimento.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor),
            nomeEstabelecimento.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor),
            nomeEstabelecimento.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configLabelPorcentagem(){
        NSLayoutConstraint.activate([
            labelPorcentagem.topAnchor.constraint(equalTo: celulaDireita.topAnchor, constant: 22),
            labelPorcentagem.centerXAnchor.constraint(equalTo: celulaDireita.centerXAnchor)
            
        ])
        
    }
    
    func configLabelMedia(){
        NSLayoutConstraint.activate([
            labelAbaixoDaMedia.topAnchor.constraint(equalTo: labelPorcentagem.bottomAnchor, constant: -10),
            labelAbaixoDaMedia.bottomAnchor.constraint(equalTo: imageViewProduto.bottomAnchor),
            labelAbaixoDaMedia.leadingAnchor.constraint(equalTo: celulaDireita.leadingAnchor, constant: 22),
            labelAbaixoDaMedia.trailingAnchor.constraint(equalTo: celulaDireita.trailingAnchor, constant: -22)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// função auxiliar para limitar tamanho de strings
extension String {
    func shorted(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + " ..."
    }
}
