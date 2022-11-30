//
//  UIViewMercado.swift
//  MelhorPreco
//
//  Created by user on 31/10/22.
//

import Foundation
import UIKit

class UIViewMercado: UIViewController{
    
    
    public var mercado: Mercado?
    
    let defaults = UserDefaults.standard
    
    var items = listaOfertas
    
    var listaAtual: String?
    
    lazy var imageViewMercado : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var viewDistancia: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewPreco: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var labelDistancia: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Distância:\n 900m"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.contentMode = .topRight
        label.numberOfLines = 2
        return label
    }()
    
    lazy var buttonGoTo: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage( UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var labelTotal: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total"
        label.textAlignment = .center
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var labelPreço: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 235,94"
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 15
        label.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        return label
    }()
    
    lazy var buttonBuy: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage( UIImage(systemName: "cart.badge.plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    lazy var labelListaAtual : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = defaults.string(forKey: "listaAtual")
        nome.textColor = UIColor(named: "AccentColor")
        nome.textAlignment = .center
        nome.adjustsFontSizeToFitWidth = true
        nome.font = UIFont.boldSystemFont(ofSize: 24)
        return nome
    }()
    
    lazy var separador : UIView = {
        let separador = UIView()
        separador.backgroundColor = UIColor(named: "AccentColor")
        separador.translatesAutoresizingMaskIntoConstraints = false
        return separador
    }()
    
    
    lazy var labelNome : UILabel = {
        let nome = UILabel()
        nome.translatesAutoresizingMaskIntoConstraints = false
        nome.text = "       "
        //nome.backgroundColor = .lightGray
        
        return nome
    }()
    
    lazy var tabelaMercados : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewOferta.self, forCellReuseIdentifier: TableViewOferta.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let mercado = mercado {
            self.title = mercado.nome
            imageViewMercado.image = UIImage(named: mercado.imagem)
            labelNome.text = mercado.nome
            self.view.addSubview(imageViewMercado)
            self.view.addSubview(viewDistancia)
            self.view.addSubview(viewPreco)
            self.viewDistancia.addSubview(labelDistancia)
            self.viewDistancia.addSubview(buttonGoTo)
            self.viewPreco.addSubview(labelTotal)
            self.viewPreco.addSubview(labelPreço)
            self.viewPreco.addSubview(buttonBuy)
            self.view.addSubview(labelListaAtual)
            self.view.addSubview(separador)
            self.view.addSubview(tabelaMercados)
            
            configImageView()
            configDistanciaView()
            configPrecoView()
            configDistancia()
            configButtonGoTo()
            configTotal()
            configPreco()
            configButtonBuy()
            configNomeLista()
            configSeparador()
            setupTabelaMercado()
            }
                
        view.backgroundColor = .white
        }

    
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewMercado.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageViewMercado.heightAnchor.constraint(equalToConstant: 160),
            imageViewMercado.widthAnchor.constraint(equalToConstant: 160),
            imageViewMercado.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func configDistanciaView(){
        NSLayoutConstraint.activate([
            viewDistancia.topAnchor.constraint(equalTo: imageViewMercado.topAnchor),
            viewDistancia.leadingAnchor.constraint(equalTo: imageViewMercado.trailingAnchor),
            viewDistancia.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewDistancia.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func configPrecoView(){
        NSLayoutConstraint.activate([
            viewPreco.topAnchor.constraint(equalTo: viewDistancia.bottomAnchor),
            viewPreco.leadingAnchor.constraint(equalTo: imageViewMercado.trailingAnchor),
            viewPreco.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewPreco.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    func configDistancia(){
        NSLayoutConstraint.activate([
            labelDistancia.centerXAnchor.constraint(equalTo: viewDistancia.centerXAnchor, constant: -20),
            labelDistancia.centerYAnchor.constraint(equalTo: viewDistancia.centerYAnchor),
            labelDistancia.topAnchor.constraint(equalTo: viewDistancia.topAnchor, constant: 20),
            labelDistancia.bottomAnchor.constraint(equalTo: viewDistancia.bottomAnchor, constant: -5),
            labelDistancia.trailingAnchor.constraint(equalTo: viewDistancia.trailingAnchor, constant: -60),
            labelDistancia.leadingAnchor.constraint(equalTo: viewDistancia.leadingAnchor, constant: 20)
            
        ])
    }
    
    func configButtonGoTo(){
        NSLayoutConstraint.activate([
            buttonGoTo.centerYAnchor.constraint(equalTo: labelDistancia.centerYAnchor),
            buttonGoTo.leadingAnchor.constraint(equalTo: labelDistancia.trailingAnchor),
            buttonGoTo.widthAnchor.constraint(equalToConstant: 30),
            buttonGoTo.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configTotal(){
        NSLayoutConstraint.activate([
            labelTotal.topAnchor.constraint(equalTo: viewPreco.topAnchor),
            labelTotal.centerXAnchor.constraint(equalTo: viewPreco.centerXAnchor, constant: -20),
            labelTotal.widthAnchor.constraint(equalTo: viewPreco.widthAnchor, constant: -20),
            labelTotal.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configPreco(){
        NSLayoutConstraint.activate([
            labelPreço.topAnchor.constraint(equalTo: labelTotal.bottomAnchor),
            labelPreço.centerXAnchor.constraint(equalTo: viewPreco.centerXAnchor, constant: -20),
            labelPreço.widthAnchor.constraint(equalToConstant: UILabel.textWidth(label: labelPreço) + 20),
            labelPreço.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configButtonBuy(){
        NSLayoutConstraint.activate([
            buttonBuy.centerYAnchor.constraint(equalTo: viewPreco.centerYAnchor, constant: -5),
            buttonBuy.leadingAnchor.constraint(equalTo: labelPreço.trailingAnchor, constant: 5),
            buttonBuy.widthAnchor.constraint(equalToConstant: 35),
            buttonBuy.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func configNomeLista(){
        NSLayoutConstraint.activate([
            labelListaAtual.topAnchor.constraint(equalTo: imageViewMercado.bottomAnchor, constant: 20),
            labelListaAtual.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelListaAtual.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            labelListaAtual.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configSeparador(){
        NSLayoutConstraint.activate([
            separador.topAnchor.constraint(equalTo: labelListaAtual.bottomAnchor, constant: 5),
            separador.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separador.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            separador.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    private func setupTabelaMercado() {
        NSLayoutConstraint.activate([
            tabelaMercados.topAnchor.constraint(equalTo: separador.bottomAnchor),
            tabelaMercados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaMercados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tabelaMercados.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    
extension UIViewMercado: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
// TODO: fazer um TableViewMercado
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewOferta.identifier,
                    for: indexPath
                    ) as? TableViewOferta else {
                return UITableViewCell()}
                let produto = self.items[(indexPath.row)]
                print(produto)
        cell.imageViewProduto.image  = UIImage(named: produto.imagem)
        cell.labelNome.text = produto.nome.shorted(to: 15)
        cell.textPreco.text = "R$" + produto.preco
        cell.labelPorcentagem.text =  produto.porcentagem + "%"
        cell.textAbaixoDaMedia.text = "Abaixo da\nmédia"
        if(indexPath.row == 0){
            cell.textAbaixoDaMedia.textColor = UIColor(named: "verde_oferta")
            cell.labelPorcentagem.textColor = UIColor(named: "verde_oferta")
        }
        else{
            cell.textAbaixoDaMedia.textColor = UIColor.darkGray
            cell.labelPorcentagem.textColor = UIColor.darkGray
        }
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailView = UIViewmercado()
        //detailView.mercado = items[indexPath.row]
        //navigationController?.pushViewController(detailView, animated: true)
    }
}

extension UILabel {
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }

    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }

    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }

    class func textWidth(font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text).width
    }

    class func textHeight(withWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        return textSize(font: font, text: text, width: width).height
    }

    class func textSize(font: UIFont, text: String, extra: CGSize) -> CGSize {
        var size = textSize(font: font, text: text)
        size.width = size.width + extra.width
        size.height = size.height + extra.height
        return size
    }

    class func textSize(font: UIFont, text: String, width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }

    class func countLines(font: UIFont, text: String, width: CGFloat, height: CGFloat = .greatestFiniteMagnitude) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = text as NSString

        let rect = CGSize(width: width, height: height)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return Int(ceil(CGFloat(labelSize.height) / font.lineHeight))
    }

    func countLines(width: CGFloat = .greatestFiniteMagnitude, height: CGFloat = .greatestFiniteMagnitude) -> Int {
        // Call self.layoutIfNeeded() if your view uses auto layout
        let myText = (self.text ?? "") as NSString

        let rect = CGSize(width: width, height: height)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font!], context: nil)

        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}
