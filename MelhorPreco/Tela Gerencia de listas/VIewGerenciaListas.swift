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
    
    // User Defaults, para ver lista atual
    let defaults = UserDefaults.standard
    
    // Array com todas as listas
    var listasCore : [ListaModel] = []
    
    // Contexto do coreData
    let managedContext =
      (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // recarregamento da tabela de listas
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
    // Botão na barra de navegação para a adicção de nova lista
    lazy var addButton : UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Nova Lista", style: .plain, target: self, action: #selector(create))
        button.image = UIImage(systemName: "plus")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return button
    }()
    
    // tabela de listas
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
    // função para criar uma nova lista a partir do botao
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
    
    // recarrega a tabela sempre que a view vai reaparecer
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        fullReloadTableData()
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define o título da view
        self.title = "Listas"
        
        // Configura a barra de navegação
        self.navigationItem.rightBarButtonItem  = addButton
        
        // adiciona elemento
        self.view.addSubview(tabelaListas)
        
        // configura elemento
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

// cria protcolo para poder se comunicar com as row da table
protocol CustomTableViewCellDelegate: AnyObject {
    func updateListaAtual(for cell: TableViewListShort)
}

// gerenciamento da table
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
        }
        else{
            cell.checkMark.isChecked = false
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
            if(listasCore[indexPath.row].name == defaults.string(forKey: "listaAtual")){
                let alert = UIAlertController(title: "", message: "Não é permitido apagar a lista selecionada como atual, selecione outra lista como atual para poder apagar esta.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: .default))
                present(alert, animated: true)
                return
            }
            // deleta o objeto do coreData
            managedContext.delete(listasCore[indexPath.row])
            // salva as aletrações e recarrega a tabela
            do {
                try managedContext.save()
                listasCore.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                fullReloadTableData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
