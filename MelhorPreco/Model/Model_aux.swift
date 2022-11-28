//
//  Model_aux.swift
//  MelhorPreco
//
//  Created by user on 28/11/22.
//

import Foundation
import CoreData

class DataManager{

    // Cria e salva nova lista no coreData e retorna a lista salva
    public func saveNewLista(Titulo name: String, context: NSManagedObjectContext ) -> ListaModel{
        // cria o requesta para reotornar a lista com determinado nome
          let fetchRequest: NSFetchRequest<ListaModel>
          fetchRequest = ListaModel.fetchRequest()

          fetchRequest.predicate = NSPredicate(
              format: "name = %@", name
          )

        do {
            // faz o request e obtem o a lista
            let object = try context.fetch(fetchRequest)
            if object.isEmpty{
                // Cria uma nova lista
                let newLista = ListaModel(context: context);
                newLista.name = name;
              // salva lista criada
              do {
                try context.save()
                  return newLista
              } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                  return ListaModel()
              }
            }
            else{
              print("Lista ja esta em armazenada!")
                return object[0]
            }
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
            return ListaModel()
        }

    }
    
    // Cria e salva novo produto no coreData e retorna o produto salvo
    public func saveNewProduto(name: String, context: NSManagedObjectContext) -> ProdutoModel{
        // cria o requesta para reotornar a lista com determinado nome
          let fetchRequest: NSFetchRequest<ProdutoModel>
          fetchRequest = ProdutoModel.fetchRequest()

          fetchRequest.predicate = NSPredicate(
              format: "name = %@", name
          )

        do {
            // faz o request e obtem o a lista
            let object = try context.fetch(fetchRequest)
            if object.isEmpty{
                // Cria uma nova lista
                let newProduto = ProdutoModel(context: context);
                newProduto.name = name;
              // salva lista criada
              do {
                try context.save()
                  return newProduto
              } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                  return ProdutoModel()
              }
            }
            else{
              print("Lista ja esta em armazenada!")
                return object[0]
            }
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
            return ProdutoModel()
        }
    }

    // Adiciona um produto ja existente no contexto em uma lista também ja existente no contexto
    public func addProduto2Lista(produto: ProdutoModel, lista: ListaModel, context: NSManagedObjectContext){
        lista.addToProdutos(produto)
        do{
            try context.save()
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }

    // Carrega uma array de listas para o CoreData
    public func load2Core (Array lists:[Lista], context: NSManagedObjectContext){
        for lista in lists{
            let listaCore = saveNewLista(Titulo: lista.nome, context: context)
            for produto in lista.produtos{
                let produtoCore = saveNewProduto(name: produto, context: context)
                addProduto2Lista(produto: produtoCore, lista: listaCore, context: context)
            }
        }
    }

    public func load2Core (Array mercados:[Mercado], context: NSManagedObjectContext){
        
        
    }
    public func load2Core (Array ofertas:[Oferta], context: NSManagedObjectContext){
        
    }
    
    // funcao que retorna os produtos de uma lista
    public func produtosFrom(lista: ListaModel, context: NSManagedObjectContext) -> [ProdutoModel] {
      let request: NSFetchRequest<ProdutoModel> = ProdutoModel.fetchRequest()
        request.predicate = NSPredicate(format: "ANY listas = %@", lista)
      var fetchedProducts: [ProdutoModel] = []
      do {
          fetchedProducts = try context.fetch(request)
      } catch let error {
        print("Error fetching products \(error)")
      }
        print("\(fetchedProducts.count) produtos presentes na lista \(lista.name!)")
      return fetchedProducts
    }
}


// TODO:
/*
func load2Core (objects Array:[Mercado_Oferta]){
    
}
 */
