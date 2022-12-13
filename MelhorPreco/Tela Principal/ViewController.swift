//
//  ViewController.swift
//  MelhorPreco
//
//  Created by user219712 on 8/22/22.
//

/*
 Tela inicial do aplicativo, contém uma lista de todas as ofertas, é possível utilizar
 a barra de pesquisa para encontrar produtos específicos, também é possivel a partir
 dessa tela cadastrar preços de produtos
*/

import Foundation
import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    // array com todas as ofertas, obtidas a partir de um json mocado
    var items = listaOfertas
    
    // itens que aparecen dentro dos resultados da pesquisa
    var itemsFiltrados: [Oferta] = []
    
    // CONFIGURACAO DO MENU DE CADASTRAR PRECOS
    
    // struc utilizada pelo cadastro via fotografia
    struct ImagePickerView: UIViewControllerRepresentable {

        @Binding var selectedImage: UIImage?
        @Environment(\.presentationMode) var isPresented
        var sourceType: UIImagePickerController.SourceType
            
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = self.sourceType
            return imagePicker
        }

        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

        }
    }
    
    
    // primeira opção do menu de cadastro de preços, manual (funcionalidade ainda não implementada)
    private lazy var first = UIAction(title: "Manualmente", image: UIImage(systemName: "square.and.pencil"), attributes: [], state: .off)
    {
        action in print ("adicao manual")
        // futuro
        // ofertas
        //let cadastroManualView = CcadastroManualView()
        //navigationController?.pushViewController(cadastroManualView, animated: true)
    }
    
    // segunda opção do menu de cadastro de preços, por fotografia
    private lazy var second = UIAction(title: "Por foto", image: UIImage(systemName: "camera"), attributes: [], state: .off)
    {
        action in print ("adicao por foto")
        ImageSelector().selecionadorImagem(self){_ in } // por enquanto não faz nada com a imagem
        // futuro: {image in <lugar onde a imagem sera armazenada> = image}
    }
    
    // elementos do menu de cadastro
    private lazy var elements:[UIAction] = [first, second]
    
    // menu de cadastro
    private lazy var menu = UIMenu(title: "Cadastrar preços", children: elements)
    
    // CONFIGURANDO BOTAO DE CADASTRAR PRECOS
    
    // Botão da barra de navegação de cadastro que vai abrigar o menu de cadastro
    lazy var addButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cadastrar Preços", image: UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), primaryAction: nil, menu: menu)

        //button.layer.borderWidth = 2
        //button.layer.cornerRadius = 15

        return button
    }()
    
    // CONFIGURACAO DO BOTAO DE PERFIL
    // Botão da barra de navegação que leva o usuário até a tela de perfil (não implementada)
    let profileButton : UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: nil, action: nil)

        //button.layer.borderWidth = 2
        //button.layer.cornerRadius = 15
        //button.layer.borderColor = UIColor.black.cgColor

        return button
    }()
    
    // logo do aplicativo que esta no centro da barra de navegação
    let logoImage : UIImageView = {
        let image = UIImageView()
        //image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        //image.backgroundColor = .lightGray
        image.layer.borderWidth = 0
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "logo_home")
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // barra de pesquisa
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.searchBarStyle = .minimal
        bar.placeholder = "Pesquie um produto..."
        return bar
    }()
    
    // tabela que apresenta os resultados da barra de pesquisa
    lazy var tabelaSearchBar : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 10
        table.layer.masksToBounds = true
        table.backgroundColor = .white
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewOferta.self, forCellReuseIdentifier: TableViewOferta.identifier)
        table.showsVerticalScrollIndicator = true
        table.estimatedRowHeight = 100
        return table
    }()
    
    // Class variable heightOfTableViewConstraint set to 1000
    var heightOfTableViewConstraint : NSLayoutConstraint!
    
    
    // tabela de ofertas
    lazy var tabelaOfertas : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
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
        // define titulo para a view
        self.title = "Ofertas"
        // define a view como delegate para a barra de pesquisa
        self.searchBar.delegate = self

        // configura a barra de navegação
        self.navigationItem.rightBarButtonItem  = addButton
        self.navigationItem.leftBarButtonItem  = profileButton
        self.navigationItem.titleView = logoImage
        
        
        // adiciona elementos à view
        self.view.addSubview(searchBar)
        self.view.addSubview(tabelaOfertas)
        self.view.addSubview(tabelaSearchBar)
        
        // configurações para permitir a natureza de auto dimensionamento da tabela de resultados da pesquisa
        tabelaSearchBar.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        heightOfTableViewConstraint = NSLayoutConstraint(item: self.tabelaSearchBar, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.0, constant: 1000)
        self.view.addConstraint(heightOfTableViewConstraint)
        
        // configura elementos da view
        setupSearchBar()
        setupTabelaSearchBar()
        setupTabelaOferta()
        
        view.backgroundColor = .white
            }
    
    override func viewWillDisappear(_ animated: Bool) {
        //tabelaSearchBar.removeObserver(self, forKeyPath: "contentSize") // isso só deve ser feito caso a view seja carregada novamente
    }
    // observa o valor do tamanho da tabela para fazer o redimensionamento sob demanda
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "contentSize"{
                if object is UITableView{
                    if let newValue = change?[.newKey]{
                        let newSize = newValue as! CGSize
                        heightOfTableViewConstraint.constant = newSize.height
                    }
                }
            }
        }

    
    private func setupSearchBar() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor ,constant: 90),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    private func setupTabelaSearchBar() {
        NSLayoutConstraint.activate([
            tabelaSearchBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tabelaSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
    }
    private func setupTabelaOferta() {
        NSLayoutConstraint.activate([
            tabelaOfertas.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tabelaOfertas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaOfertas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaOfertas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// gerenciamneto da tabela de ofertas, que além de abrigar as ofertas também abriga o banner de promoções e a label de "Principais ofertas"
extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(tableView == tabelaOfertas){
            return items.count + 2 // + 1 carrocel ofertas, + 1 titulo = 2
        }
        if(tableView == tabelaSearchBar){
            return itemsFiltrados.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Tabela da barra de ofertas
        if(tableView == tabelaOfertas){
            // Primeiro elemento é a imagem de promoção
            if (indexPath.row == 0){
                guard let cell = tableView.dequeueReusableCell(
                            withIdentifier: TableViewImageAd.identifier,
                            for: indexPath
                            ) as? TableViewImageAd else {
                        return UITableViewCell()}
                return cell
            }
            // Segundo elemento é o titulo "Principais Ofertas"
            if (indexPath.row == 1){
                let cell = TableViewTitle()
                cell.title.text = "Principais ofertas"
                return cell
            }
            // Resto dos elementos são as ofertas
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewOferta.identifier,
                        for: indexPath
                        ) as? TableViewOferta else {
                    return UITableViewCell()}
                    let oferta = self.items[(indexPath.row - 2)] // - 1 porque o primeiro é a imagem e -1 pelo titulo
                    print(oferta)
            cell.imageViewProduto.image  = UIImage(named: oferta.imagem)
            cell.labelNome.text = oferta.nome.shorted(to: 15)
            cell.textPreco.text = "R$" + oferta.preco
            cell.nomeEstabelecimento.text = oferta.estabelecimento
            cell.labelPorcentagem.text =  oferta.porcentagem + "%"
            cell.labelAbaixoDaMedia.text = "Abaixo da\nmédia"
            return cell
        }
        // Tabela da barra de pesquisa
        if(tableView == tabelaSearchBar){
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewOferta.identifier,
                        for: indexPath
                        ) as? TableViewOferta else {
                    return UITableViewCell()}
                    let oferta = self.itemsFiltrados[(indexPath.row)]
                    print(oferta)
            cell.imageViewProduto.image  = UIImage(named: oferta.imagem)
            cell.labelNome.text = oferta.nome.shorted(to: 15)
            cell.textPreco.text = "R$" + oferta.preco
            cell.nomeEstabelecimento.text = oferta.estabelecimento
            cell.labelPorcentagem.text =  oferta.porcentagem + "%"
            cell.labelAbaixoDaMedia.text = "Abaixo da\nmédia"
            //self.tabelaSearchBar.sizeToFit()
            return cell
        }
        return UITableViewCell()
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if(tableView == tabelaOfertas){
            // Carrocel de ofertas
            if(indexPath.row == 0){
                return 174
            }
            // Titulo
            if(indexPath.row == 1){
                return 75
            }
            return 100
        }
        if(tableView == tabelaSearchBar){
            return 100
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tabelaOfertas){
            // Carrocel de ofertas
            if(indexPath.row == 0){
                return
            }
            // Titulo
            if(indexPath.row == 1){
                return
            }
            // ofertas
            let detailView = UIViewOferta()
            detailView.oferta = items[indexPath.row - 2]
            navigationController?.pushViewController(detailView, animated: true)
        }
        if(tableView == tabelaSearchBar){
            // ofertas
            let detailView = UIViewOferta()
            detailView.oferta = itemsFiltrados[indexPath.row]
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        // Class variable heightOfTableViewConstraint set to 1000
        itemsFiltrados = items.filter { (item: Oferta) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.nome.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tabelaSearchBar.reloadData()
        //tabelaSearchBar.sizeToFit()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        itemsFiltrados = []
        tabelaSearchBar.reloadData()
    }
     
}
