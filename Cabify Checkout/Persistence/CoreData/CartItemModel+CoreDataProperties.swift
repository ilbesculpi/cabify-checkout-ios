//
//  CartItemModel+CoreDataProperties.swift
//  
//
//  Created by Ilbert Esculpi on 7/30/19.
//
//

import Foundation
import CoreData


extension CartItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItemModel> {
        return NSFetchRequest<CartItemModel>(entityName: "CartItemModel")
    }

    @NSManaged public var quantity: Int32
    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var unitPrice: Float

}
