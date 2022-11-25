//
//  DataManager.swift
//  MelhorPreco
//
//  Created by user on 22/11/22.
//

import Foundation
import CoreData

class DataManager {
    
  static let shared = DataManager()
    
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
    
  //Core Data Saving support
  func save () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
          try context.save()
          print("Contexto salvo com sucesso!")
      } catch {
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
