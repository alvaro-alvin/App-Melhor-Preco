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
        let viewList = UINavigationController(rootViewController: ListsController())
        let viewGas = UINavigationController(rootViewController: ViewGas())
        
        self.setViewControllers([viewGas, viewHome, viewList], animated: true)
        // define a home como tela inicial
        self.selectedIndex = 1
        self.tabBar.barTintColor = UIColor.white // parece não funcionar
        
    }
    
}

class ViewHome:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        //self.view.backgroundColor = .orange
    }
    
}

class ViewList:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List"
        self.view.backgroundColor = .white
    }
    
}

class ViewGas:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gas"
        self.view.backgroundColor = .yellow
    }
    
}
