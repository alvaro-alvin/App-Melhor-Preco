//
//  UIViewOferta.swift
//  MelhorPreco
//
//  Created by user on 03/10/22.
//

// AINDA NAO ESTA SENDO USADO...

import Foundation
import UIKit

class UIViewOferta: UIViewController{
    
    
    public var oferta: Oferta?
    
    var items = listaMercados    
    
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
        // Do any additional setup after loading the view.
        if let oferta = oferta {
            self.title = oferta.nome
            imageViewProduto.image = UIImage(named: oferta.imagem)
            labelNome.text = oferta.nome
            self.view.addSubview(imageViewProduto)
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
    
    
    private func setupTabelaMercado() {
        NSLayoutConstraint.activate([
            tabelaMercados.topAnchor.constraint(equalTo: labelNome.bottomAnchor),
            tabelaMercados.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaMercados.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaMercados.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
    
extension UIViewOferta: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TableViewMercado.identifier,
                    for: indexPath
                    ) as? TableViewMercado else {
                return UITableViewCell()}
                let mercado = self.items[(indexPath.row)]
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let detailView = UIViewOferta()
        //detailView.oferta = items[indexPath.row]
        //navigationController?.pushViewController(detailView, animated: true)
    }
}





