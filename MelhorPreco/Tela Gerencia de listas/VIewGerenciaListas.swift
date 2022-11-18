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
    
    var listas = loadJson(filename: "listas")
    
    var listasCore : [NSManagedObject] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "CoreDataRelationship")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "ListaModel")
      
      //3
      do {
        listasCore = try managedContext.fetch(fetchRequest)
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
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
            
            
          self.tabelaOfertas.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "ListaModel",
                                   in: managedContext)!
      
      let newLista = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      newLista.setValue(name, forKeyPath: "name")
      
      // 4
      do {
        try managedContext.save()
        listasCore.append(newLista)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    @objc func search(sender: UIButton!) {
        let alert = UIAlertController(title: "Encontrar",
                                      message: "Busque por nome",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Procurar",
                                       style: .default) {
          [unowned self] action in
                                        
          guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
              return
          }
            
            self.find(name: nameToSave)
            
            
          self.tabelaOfertas.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func find(name: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "ListaModel",
                                   in: managedContext)!
      
      let newLista = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      newLista.setValue(name, forKeyPath: "name")
        
        // Create a fetch request with a string filter
        // for an entity’s name
        let fetchRequest: NSFetchRequest<ListaModel>
        fetchRequest = ListaModel.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "name = %@", name
        )


        // Perform the fetch request to get the objects
        // matching the predicate
      
      // 4
      do {
        let object = try managedContext.fetch(fetchRequest)
          print("nome da lista : \(object[0].name!)")
          let novo_produto = ProdutoModel(context: persistentContainer.viewContext)
          novo_produto.name = "arroz"
          object[0].addToProdutos(novo_produto)
          var i = 0
          // https://medium.com/@meggsila/core-data-relationship-in-swift-5-made-simple-f51e19b28326
          for produto in produtos(lista: object[0]) {
              i += 1
              print("produto \(i + 1) : \(produto.name!)")
          }
          
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func produtos(lista: ListaModel) -> [ProdutoModel] {
      let request: NSFetchRequest<ProdutoModel> = ProdutoModel.fetchRequest()
      request.predicate = NSPredicate(format: "listas = %@", lista)
      var fetchedSongs: [ProdutoModel] = []
      do {
        fetchedSongs = try persistentContainer.viewContext.fetch(request)
      } catch let error {
        print("Error fetching songs \(error)")
      }
      return fetchedSongs
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


