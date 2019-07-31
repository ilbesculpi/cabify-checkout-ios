//
//  CartItemModel+CoreDataProperties.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 7/30/19.
//  Copyright © 2019 Cabify. All rights reserved.
//
//

import Foundation
import CoreData


extension CartItemModel {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CartItemModel> {
        return NSFetchRequest<CartItemModel>(entityName: "CartItemModel")
    }

    @NSManaged public var quantity: Int32
    @NSManaged public var code: String
    @NSManaged public var name: String
    @NSManaged public var unitPrice: Float

}
