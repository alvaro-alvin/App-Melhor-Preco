//
//  TabbarController.swift
//  MelhorPreco
//
//  Created by user219712 on 8/31/22.
//

import Foundation
import UIKit

class TabbarController:UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBarController()
        
    }
    
    private func setupBarController() {
        
        let viewHome = UINavigationController(rootViewController: ViewController())
        let viewList = UINavigationController(rootViewController: UIViewLists())
        let viewGas = UINavigationController(rootViewController: MapViewController())
        
        self.setViewControllers([viewGas, viewHome, viewList], animated: true)
        // define a home como tela inicial
        self.selectedIndex = 1
        //
        self.tabBar.unselectedItemTintColor = UIColor.black
        // define a cor do item selecionado
        self.tabBar.tintColor = UIColor(red: 0.90, green: 0.62, blue: 0.06, alpha: 1.00)
        // define a cor de fundo
        self.tabBar.backgroundColor = UIColor.white

        
        self.tabBar.items?[0].image = UIImage(systemName: "car")
        self.tabBar.items?[1].image = UIImage(systemName: "house")
        self.tabBar.items?[2].image = UIImage(systemName: "cart")
    }
    
}

class ViewHome:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ofertas"
    }
    
}

class ViewList:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Listas e compras"
    }
    
}

class ViewGas:UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gasolina"
    }
    
}
