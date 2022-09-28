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
        //button.backgroundColor = .lightGray
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.setImage(UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let profileButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        //button.backgroundColor = .lightGray
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.setImage(UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    let logoImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        //image.backgroundColor = .lightGray
        image.layer.borderWidth = 0
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "logo_home")
        return image
    }()
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.placeholder = "Pesquie um produto..."
        return bar
    }()
    
    lazy var tabelaOfertas : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewImageAd.self, forCellReuseIdentifier: TableViewImageAd.identifier)
        table.register(TableViewOferta.self, forCellReuseIdentifier: TableViewOferta.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // title = "Home"
        
        self.view.addSubview(addButton)
        self.view.addSubview(profileButton)
        self.view.addSubview(logoImage)
        self.view.addSubview(searchBar)
        self.view.addSubview(tabelaOfertas)
        
        //setupNavBar()
        setupProfileButton()
        setupAddButton()
        setupLogoImage()
        setupSearchBar()
        setupTabelaOferta()
        
        
                                
                            
        view.backgroundColor = .white
            }
    
    private func setupNavBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: nil)    }
    
    private func setupLogoImage() {
    
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 45),
            logoImage.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
     
    private func setupProfileButton() {
        NSLayoutConstraint.activate([
            profileButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            profileButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
      
    private func setupAddButton() {
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupSearchBar() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: logoImage.bottomAnchor ,constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    private func setupTabelaOferta() {
        NSLayoutConstraint.activate([
            tabelaOfertas.topAnchor.constraint(equalTo: searchBar.bottomAnchor ,constant: 10),
            tabelaOfertas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaOfertas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaOfertas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewImageAd.identifier,
                        for: indexPath
                        ) as? TableViewImageAd else {
                    return UITableViewCell()}
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewOferta.identifier,
                    for: indexPath
                    ) as? TableViewOferta else {
                return UITableViewCell()}
                let oferta = self.items[(indexPath.row - 1)] // - 1 porque o primeiro é a imagem
                print(oferta)
        cell.imageViewProduto.image  = UIImage(named: oferta.imagem)
        cell.labelNome.text = oferta.nome
        cell.textPreco.text = "R$" + oferta.preco
        cell.textNomeEstabelecimento.text = oferta.estabelecimento
        cell.labelPorcentagem.text =  oferta.porcentagem + "%"
        cell.textAbaixoDaMedia.text = "Abaixo da média"
        return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(indexPath.row == 0){
            return 174
        }
        return 100
    }
     
}
