//
//  UIViewOferta.swift
//  MelhorPreco
//
//  Created by user on 03/10/22.
//

// AINDA NAO ESTA SENDO USADO...

import SwiftUI

class UIViewOferta: UIViewController{
    
    public var oferta: Oferta?
    
    lazy var celulaEsquerda : UIView = {
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
    
    
    lazy var imageViewProduto : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var labelNome : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "       "
        //nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    lazy var textPreco : UILabel = {
        let preco = UILabel()
        preco.translatesAutoresizingMaskIntoConstraints = false
        preco.text = "      "
        preco.textColor = .darkGray
        preco.font = UIFont.systemFont(ofSize: 14)
        //preco.backgroundColor = .lightGray
        
        return preco
    }()
    
    lazy var textNomeEstabelecimento : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "         "
        nome.textColor = .lightGray
        nome.font = UIFont.systemFont(ofSize: 12)
        //nome.backgroundColor = .darkGray

        return nome
    }()
    
    var textAbaixoDaMedia : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "Abaixo da\nmédia"
        nome.textColor = UIColor(red: 0.60, green: 0.82, blue: 0.56, alpha: 1.00)
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
        nome.textColor = UIColor(red: 0.60, green: 0.82, blue: 0.56, alpha: 1.00)
        nome.font = UIFont.boldSystemFont(ofSize: 18.0)
        return nome
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let oferta = oferta {
            self.title = oferta.nome
            imageViewProduto.image = UIImage(named: oferta.imagem)
            labelNome.text = oferta.nome
            textNomeEstabelecimento.text = oferta.estabelecimento
            textPreco.text = "R$" + oferta.preco
            labelPorcentagem.text = oferta.porcentagem + "%"
            self.view.addSubview(imageViewProduto)
            self.view.addSubview(celulaDireita)
            self.view.addSubview(celulaEsquerda)
            self.view.addSubview(labelNome)
            self.view.addSubview(textNomeEstabelecimento)
            self.view.addSubview(textPreco)
            self.view.addSubview(labelPorcentagem)
            self.view.addSubview(textAbaixoDaMedia)
            configImageView()
            configLabelNome()
            configCelulaDireita()
            configCelulaEsquerda()
            configTextEstabelecimento()
            configTextPreco()
            configLabelPorcentagem()
            configTextMedia()
            }
                
        view.backgroundColor = .white
        }

    
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewProduto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewProduto.heightAnchor.constraint(equalToConstant: 120),
            imageViewProduto.widthAnchor.constraint(equalToConstant: 120),
            imageViewProduto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func configLabelNome(){
        NSLayoutConstraint.activate([
            labelNome.topAnchor.constraint(equalTo: imageViewProduto.bottomAnchor, constant: 10),
            labelNome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelNome.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configCelulaDireita(){
        NSLayoutConstraint.activate([
            celulaDireita.topAnchor.constraint(equalTo: labelNome.bottomAnchor, constant: 10),
            celulaDireita.heightAnchor.constraint(equalToConstant: 100),      celulaDireita.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (2/3*view.frame.width) + 10),
            celulaDireita.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
    }
    
    func configCelulaEsquerda(){
        NSLayoutConstraint.activate([
            celulaEsquerda.topAnchor.constraint(equalTo: labelNome.bottomAnchor, constant: 10),
            celulaEsquerda.heightAnchor.constraint(equalToConstant: 100),
            celulaEsquerda.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            celulaEsquerda.trailingAnchor.constraint(equalTo: celulaDireita.leadingAnchor, constant: -10)
        ])
    }
    

    
    func configTextPreco(){
        NSLayoutConstraint.activate([
            textPreco.topAnchor.constraint(equalTo: labelNome.bottomAnchor),
            textPreco.bottomAnchor.constraint(equalTo: textNomeEstabelecimento.topAnchor),
            textPreco.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor),
            textPreco.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor)

        ])
        
    }
    
    func configTextEstabelecimento(){
        NSLayoutConstraint.activate([
            textNomeEstabelecimento.bottomAnchor.constraint(equalTo: celulaEsquerda.bottomAnchor),
            textNomeEstabelecimento.trailingAnchor.constraint(equalTo: celulaEsquerda.trailingAnchor),
            textNomeEstabelecimento.leadingAnchor.constraint(equalTo: celulaEsquerda.leadingAnchor),
            textNomeEstabelecimento.heightAnchor.constraint(equalToConstant: 25)
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
    
}
