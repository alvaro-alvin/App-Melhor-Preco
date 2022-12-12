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
    
    let defaults = UserDefaults.standard
    
    var listasCore : [ListaModel] = []
    
    
    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fullReloadTableData(){
        do {
            listasCore = try managedContext.fetch(ListaModel.fetchRequest())
            DispatchQueue.main.async {
                self.tabelaListas.reloadData()
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    // CONFIGURANDO BOTAO DE CADASTRO DE NOVA LISTA
    
    lazy var addButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Nova Lista", style: .plain, target: self, action: #selector(create))
        button.image = UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return button
    }()

    lazy var tabelaListas : UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.isScrollEnabled = true
        table.delegate = self
        table.dataSource = self
        table.register(TableViewListShort.self, forCellReuseIdentifier: TableViewListShort.identifier)
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    @objc func create(sender: UIButton!) {
        let alert = UIAlertController(title: "Nova lista",
                                      message: "Digite o nome da nova lista",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Adicionar",
                                       style: .default) {
          [unowned self] action in
                                        
          guard let textField = alert.textFields?.first,
            let nameToSave = textField.text else {
              return
          }
            
            self.save(name: nameToSave)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar",
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
          fullReloadTableData()
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
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        fullReloadTableData()
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Listas"
        
        self.navigationItem.rightBarButtonItem  = addButton
        
        self.view.addSubview(tabelaListas)
        
        setupTabelaOferta()
        
        view.backgroundColor = .white
        }
    private func setupTabelaOferta() {
        NSLayoutConstraint.activate([
            tabelaListas.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabelaListas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tabelaListas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tabelaListas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

protocol CustomTableViewCellDelegate: AnyObject {
    func updateListaAtual(for cell: TableViewListShort)
}

extension ViewGerenciaListas: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CustomTableViewCellDelegate {
    func updateListaAtual(for cell: TableViewListShort) {
        //code
        fullReloadTableData()
        print("deu reload")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listasCore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: TableViewListShort.identifier,
                        for: indexPath
                        ) as? TableViewListShort else {
                    return UITableViewCell()}
            let lista = listasCore[indexPath.row]
            cell.delegate = self
            cell.listName.text = lista.name
            cell.checkMark.associatedName = lista.name
        if(lista.name == defaults.string(forKey: "listaAtual")){
            cell.checkMark.isChecked = true
            print("tenho \(lista.name!) é \(defaults.string(forKey: "listaAtual")!) - OK MARCADO")
        }
        else{
            cell.checkMark.isChecked = false
            print("tenho \(lista.name!) é \(defaults.string(forKey: "listaAtual")!) - NÃO MARCADO")
        }
            return cell
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editorView = UIViewListEditor()
        editorView.listaAtual = listasCore[indexPath.row]
        navigationController?.pushViewController(editorView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // deleta o objeto do coreData
            managedContext.delete(listasCore[indexPath.row])
            // salva as aletrações e recarrega a tabela
            do {
                try managedContext.save()
                tableView.deleteRows(at: [indexPath], with: .fade)

                fullReloadTableData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
