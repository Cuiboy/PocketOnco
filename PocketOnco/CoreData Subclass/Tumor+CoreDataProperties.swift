//
//  Tumor+CoreDataProperties.swift
//  PocketOnco
//
//  Created by Patrick Cui on 12/10/18.
//
//

import Foundation
import CoreData


extension Tumor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tumor> {
        return NSFetchRequest<Tumor>(entityName: "Tumor")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var grade: Int16
    @NSManaged public var stage: Int16
    @NSManaged public var name: String?
    @NSManaged public var isHealthy: Bool
    @NSManaged public var type: String?

}
