//
//  ListsContoller.swift
//  MelhorPreco
//
//  Created by user on 25/09/22.
//

import Foundation
import UIKit

class ListsController: UIViewController {
    
    private lazy var lista1 = UIAction(title: "Lista 1", state: .on) { action in
        print("Lista 1")
    }
    
    private lazy var lista2 = UIAction(title: "Lista 2", state: .off) { action in
        print("Lista 2")
    }
    
    private lazy var lista3 = UIAction(title: "Lista 3", state: .off) { action in
        print("Lista 3")
    }
    
    private lazy var elements: [UIAction] = [lista1, lista2, lista3]
    
    private lazy var menu = UIMenu(title: "Listas", children: elements)
    
    private lazy var listasButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        //button.backgroundColor = .lightGray
        button.setTitle("Lista 1", for: .normal)
        button.showsMenuAsPrimaryAction = true
        button.menu = menu
        return button
    }()
    
    let dataSource: KeyValuePairs = [
        "Amaciante": 1,
        "Desodorante": 1,
        "Litro de leite": 3
    ]
    
    private lazy var listagemProdutos: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGroupedBackground
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Listas"
        
        self.view.addSubview(listasButton)
        self.view.addSubview(listagemProdutos)
        
        //setupNavBar()
        setupListasButton()
        setupListagemProdutos()
        
        view.backgroundColor = .white
    }
    
    private func setupListasButton() {
        NSLayoutConstraint.activate([
            listasButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            listasButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            listasButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupListagemProdutos() {
        NSLayoutConstraint.activate([
            listagemProdutos.topAnchor.constraint(equalTo: view.topAnchor),
            listagemProdutos.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listagemProdutos.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listagemProdutos.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
