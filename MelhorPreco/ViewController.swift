//
//  ViewController.swift
//  MelhorPreco
//
//  Created by user219712 on 8/22/22.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    var items = listaOfertas
    
    let addButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 15
        return button
    }()
    let profileButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 0
        button.layer.cornerRadius = 15
        return button
    }()
    let logoImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.backgroundColor = .lightGray
        image.layer.borderWidth = 0
        image.layer.cornerRadius = 10
        return image
    }()
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        return bar
    }()
    lazy var tabelaOfertas : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .red
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewOferta.self, forCellReuseIdentifier: TableViewOferta.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tabelaOfertas)
        self.view.addSubview(addButton)
        self.view.addSubview(profileButton)
        self.view.addSubview(logoImage)
        self.view.addSubview(searchBar)
        
        
        setupConstraints()
                                
                            
        view.backgroundColor = .white
            }
    
    private func setupConstraints() {
    
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 45),
            logoImage.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            profileButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            profileButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            profileButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            addButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: logoImage.bottomAnchor ,constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            tabelaOfertas.topAnchor.constraint(equalTo: searchBar.bottomAnchor ,constant: 10),
            tabelaOfertas.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tabelaOfertas.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewOferta.identifier,
                    for: indexPath
                    ) as? TableViewOferta else {
                return UITableViewCell()}
                let oferta = self.items[indexPath.row]
                print(oferta)
        cell.imageViewProduto.image  = UIImage(named: oferta.imagem)
        cell.labelNome.text = oferta.nome
        cell.textPreco.text = oferta.preco
        cell.textNomeEstabelecimento.text = oferta.estabelecimento
        cell.labelPorcentagem.text =  oferta.porcentagem
        cell.textAbaixoDaMedia.text = "Abaixo da media"
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
     
}
