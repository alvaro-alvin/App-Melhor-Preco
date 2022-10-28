//
//  UIViewOferta.swift
//  MelhorPreco
//
//  Created by user on 28/10/22.
//

// AINDA NAO ESTA SENDO USADO...

import Foundation
import UIKit

class UIViewLists: UIViewController{
    
    
    public var listaAtual: Lista?
    
    var itemsListas = listaListas
    var itemsMercados = listaMercadosLista
    
    lazy var buttonListas : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.lightGray
        button.layer.cornerRadius = 10
        button.setTitle("Gerenciar listas", for: .normal)
        return button
    }()
    
    lazy var viewListaAtual : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 0.98, blue: 0.97, alpha: 1)
        view.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        return view
    }()
    lazy var separador : UIView = {
        let separador = UIView()
        separador.backgroundColor = UIColor(named: "AccentColor")
        separador.translatesAutoresizingMaskIntoConstraints = false
        return separador
    }()
    
    lazy var tituloListaAtual : UILabel = {
        let titulo = UILabel()
        titulo.translatesAutoresizingMaskIntoConstraints = false
        titulo.font = .boldSystemFont(ofSize: 21)
        return titulo
        
    }()
    
    lazy var tableLista : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.delegate = self
        table.dataSource = self
        table.register(TableViewLista.self, forCellReuseIdentifier: TableViewLista.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    


    lazy var tabelaMercados : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewMercado.self, forCellReuseIdentifier: TableViewMercado.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaAtual = itemsListas[0]
        // Do any additional setup after loading the view.

        self.title = "Listas e compras"
        
        tituloListaAtual.text = listaAtual?.nome

        self.view.addSubview(buttonListas)
        self.view.addSubview(viewListaAtual)
        self.viewListaAtual.addSubview(separador)
        self.viewListaAtual.addSubview(tituloListaAtual)
        self.viewListaAtual.addSubview(tableLista)
        self.view.addSubview(tabelaMercados)
        configButtonListas()
        configListView()
        configSeparador()
        configLabelTitulo()
        configTableLista()
        configTableMercado()
        
                
        view.backgroundColor = .white
        }

    func configButtonListas(){
        NSLayoutConstraint.activate([
            buttonListas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonListas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonListas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonListas.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configListView(){
        NSLayoutConstraint.activate([
            viewListaAtual.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewListaAtual.topAnchor.constraint(equalTo: buttonListas.bottomAnchor, constant: 10),
            viewListaAtual.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewListaAtual.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewListaAtual.heightAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func configSeparador(){
        NSLayoutConstraint.activate([
            separador.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 10),
            separador.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor, constant: -10),
            separador.topAnchor.constraint(equalTo: viewListaAtual.topAnchor, constant: 45),
            separador.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configLabelTitulo(){
        NSLayoutConstraint.activate([
            tituloListaAtual.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 20),
            tituloListaAtual.topAnchor.constraint(equalTo: viewListaAtual.topAnchor, constant: 10),
            tituloListaAtual.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor),
            tituloListaAtual.bottomAnchor.constraint(equalTo: separador.topAnchor)
        ])
    }
    
    func configTableLista(){
        NSLayoutConstraint.activate([
            tableLista.topAnchor.constraint(equalTo: separador.bottomAnchor, constant: 10),
            tableLista.bottomAnchor.constraint(equalTo: viewListaAtual.bottomAnchor, constant: -10),
            tableLista.leadingAnchor.constraint(equalTo: viewListaAtual.leadingAnchor, constant: 20),
            tableLista.trailingAnchor.constraint(equalTo: viewListaAtual.trailingAnchor, constant: -20)
        ])
    }
    
    private func configTableMercado() {
        NSLayoutConstraint.activate([
            tabelaMercados.topAnchor.constraint(equalTo: viewListaAtual.bottomAnchor, constant: 20),
            tabelaMercados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaMercados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaMercados.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
    }
}

extension UIViewLists: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == tableLista){
            return 1
        }
        if(tableView == tabelaMercados){
            return 1
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tableLista){
            return listaAtual!.produtos.count
        }
        if(tableView == tabelaMercados){
            return self.itemsMercados.count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tableLista){
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewLista.identifier,
                    for: indexPath
                    ) as? TableViewLista else {
                return UITableViewCell()}
        cell.labelProduto.text = "• " + listaAtual!.produtos[indexPath.row]
        print(listaAtual!.produtos[indexPath.row])
        cell.selectionStyle = .none
        return cell;
        }
        if(tableView == tabelaMercados){
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewMercado.identifier,
                        for: indexPath
                        ) as? TableViewMercado else {
                    return UITableViewCell()}
                    let mercado = self.itemsMercados[(indexPath.row)]
                    print(mercado)
            cell.imageViewProduto.image  = UIImage(named: mercado.imagem)
            cell.labelNome.text = mercado.nome
            cell.textPreco.text = "R$" + mercado.preco
            cell.labelPorcentagem.text =  mercado.porcentagem + "%"
            cell.textAbaixoDaMedia.text = "Abaixo da\nmédia"
            if(indexPath.row == 0){
                cell.textAbaixoDaMedia.textColor = UIColor(named: "verde_oferta")
                cell.labelPorcentagem.textColor = UIColor(named: "verde_oferta")
            }
            return cell
        }
        return UITableViewCell()
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(tableView == tableLista){
            return 25
        }
        if(tableView == tabelaMercados){
            return 100
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailView = UIViewOferta()
        //detailView.oferta = items[indexPath.row]
        //navigationController?.pushViewController(detailView, animated: true)
    }
}
 





