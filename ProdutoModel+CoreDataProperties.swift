//
//  ProdutoModel+CoreDataProperties.swift
//  MelhorPreco
//
//  Created by user on 09/11/22.
//
//

import Foundation
import CoreData


extension ProdutoModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProdutoModel> {
        return NSFetchRequest<ProdutoModel>(entityName: "ProdutoModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var listas: NSSet?

}

// MARK: Generated accessors for listas
extension ProdutoModel {

    @objc(addListasObject:)
    @NSManaged public func addToListas(_ value: ListaModel)

    @objc(removeListasObject:)
    @NSManaged public func removeFromListas(_ value: ListaModel)

    @objc(addListas:)
    @NSManaged public func addToListas(_ values: NSSet)

    @objc(removeListas:)
    @NSManaged public func removeFromListas(_ values: NSSet)

}

extension ProdutoModel : Identifiable {

}
