//
//  ListaModel+CoreDataProperties.swift
//  MelhorPreco
//
//  Created by user on 25/11/22.
//
//

import Foundation
import CoreData


extension ListaModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListaModel> {
        return NSFetchRequest<ListaModel>(entityName: "ListaModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var produtos: NSSet?

}

// MARK: Generated accessors for produtos
extension ListaModel {

    @objc(addProdutosObject:)
    @NSManaged public func addToProdutos(_ value: ProdutoModel)

    @objc(removeProdutosObject:)
    @NSManaged public func removeFromProdutos(_ value: ProdutoModel)

    @objc(addProdutos:)
    @NSManaged public func addToProdutos(_ values: NSSet)

    @objc(removeProdutos:)
    @NSManaged public func removeFromProdutos(_ values: NSSet)

}

extension ListaModel : Identifiable {

}
