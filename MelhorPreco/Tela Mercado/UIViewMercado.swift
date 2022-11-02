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
    
    var items = listaOfertas
    
    var listaAtual: String?
    
    lazy var imageViewMercado : UIImageView = {
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
            self.view.addSubview(labelNome)
            self.view.addSubview(tabelaMercados)
            configImageView()
            configLabelNome()
            setupTabelaMercado()
            }
                
        view.backgroundColor = .white
        }

    
    
    func configImageView(){
        NSLayoutConstraint.activate([
            imageViewMercado.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewMercado.heightAnchor.constraint(equalToConstant: 120),
            imageViewMercado.widthAnchor.constraint(equalToConstant: 120),
            imageViewMercado.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    func configLabelNome(){
        NSLayoutConstraint.activate([
            labelNome.topAnchor.constraint(equalTo: imageViewMercado.bottomAnchor, constant: 10),
            labelNome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelNome.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func setupTabelaMercado() {
        NSLayoutConstraint.activate([
            tabelaMercados.topAnchor.constraint(equalTo: labelNome.bottomAnchor),
            tabelaMercados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaMercados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
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
        cell.labelNome.text = produto.nome
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





