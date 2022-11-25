//
//  VIewGerenciaListas.swift
//  MelhorPreco
//
//  Created by user on 07/11/22.
//

import Foundation
import UIKit
import CoreData


class ViewGerenciaListas: UIViewController {
    
    //var items = listaOfertas
    
    //var itemsFiltrados: [Oferta] = []
    
    //var listas = loadJson(filename: "listas")
    
    var listasCore : [NSManagedObject] = []
    
    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func reloadTableData(){
        do {
            listasCore = try managedContext.fetch(ListaModel.fetchRequest())
            DispatchQueue.main.async {
                self.tabelaOfertas.reloadData()
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      reloadTableData()
      
    }

    lazy var tabelaOfertas : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewListEdit.self, forCellReuseIdentifier: TableViewListEdit.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    lazy var  buttonAdd : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    
    lazy var  buttonSelect : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "doc.text.magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    @objc func create(sender: UIButton!) {
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
          [unowned self] action in
                                        
          guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
              return
          }
            
            self.save(name: nameToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    // adiciona nova lista ao CoreData
    func save(name: String) {
        
        // Cria uma nova lista
        let newLista = ListaModel(context: managedContext);
        newLista.name = name;
      // salva lista criada
      do {
        try managedContext.save()
        reloadTableData()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    @objc func search(sender: UIButton!) {
        let alert = UIAlertController(title: "Adicionar arroz",
                                      message: "Digite o nome da lista a qual voce quer adicionar arroz",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Essa mesmo",
                                       style: .default) {
          [unowned self] action in
                                        
          guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
              return
          }
            
            self.find(name: nameToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Não quero adicionar arroz a nada",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func find(name: String) {
      // cria o requesta para reotornar a lista com determinado nome
        let fetchRequest: NSFetchRequest<ListaModel>
        fetchRequest = ListaModel.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "name = %@", name
        )

      do {
          // faz o request e obtem o a lista
          let object = try managedContext.fetch(fetchRequest)
          print("nome da lista : \(object[0].name!)")
          
          // gera novo produto
          print("gerando novo produto...")
          let novo_produto = ProdutoModel(context: managedContext)
          novo_produto.name = "Arroz"
          
          // Adiciona o porduto gerado à lista
          print("Adicionando arroz a lista...")
          object[0].addToProdutos(novo_produto)
          
          // salva o que foi feito
          try managedContext.save()
          
          // extrai os produtos da lista selecionada
          var i = 0
          print("Extraindo produtos da lista")
          let produtos_da_lista: [ProdutoModel] = produtos(lista: object[0])
          // percorre a lista e printa os produtos
          print("tamanho \(produtos_da_lista.count)")
          for produto in  produtos_da_lista{
              i += 1
              print("produto \(i) : \(produto.name!)")
          }
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    
    // funcao que retorna os produtos de uma lista
    func produtos(lista: ListaModel) -> [ProdutoModel] {
      let request: NSFetchRequest<ProdutoModel> = ProdutoModel.fetchRequest()
        request.predicate = NSPredicate(format: "ANY listas = %@", lista)
      var fetchedProducts: [ProdutoModel] = []
      do {
          fetchedProducts = try self.managedContext.fetch(request)
      } catch let error {
        print("Error fetching products \(error)")
      }
      return fetchedProducts
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Gerencia Listas"
        
        
        self.view.addSubview(buttonAdd)
        self.view.addSubview(buttonSelect)
        self.view.addSubview(tabelaOfertas)
        
        buttonAdd.addTarget(self, action: #selector(create), for: .touchUpInside)
        buttonSelect.addTarget(self, action: #selector(search), for: .touchUpInside)
        
        
        setupButtonAdd()
        setupButtonSelect()
        setupTabelaOferta()
        
        view.backgroundColor = .white
        }
    
    
    private func setupButtonAdd() {
        NSLayoutConstraint.activate([
            buttonAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            buttonAdd.widthAnchor.constraint(equalToConstant: 25),
            buttonAdd.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonAdd.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func setupButtonSelect() {
        NSLayoutConstraint.activate([
            buttonSelect.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            buttonSelect.widthAnchor.constraint(equalToConstant: 25),
            buttonSelect.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonSelect.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    private func setupTabelaOferta() {
        NSLayoutConstraint.activate([
            tabelaOfertas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabelaOfertas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaOfertas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaOfertas.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor)
        ])
    }
}

extension ViewGerenciaListas: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listasCore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewListEdit.identifier,
                        for: indexPath
                        ) as? TableViewListEdit else {
                    return UITableViewCell()}
            let lista = listasCore[indexPath.row]
            cell.textProduto.text = lista.value(forKey: "name") as? String
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
     
}


