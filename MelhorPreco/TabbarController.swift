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
        
        let viewHome = UINavigationController(rootViewController: ViewHome())
        let viewList = UINavigationController(rootViewController: ViewList())
        let viewGas = UINavigationController(rootViewController: ViewGas())
        
        self.setViewControllers([viewGas, viewHome, viewList], animated: true)
    }
    
}

class ViewHome:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = .orange
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
