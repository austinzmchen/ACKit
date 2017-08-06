//
//  Q3Episode+CoreDataProperties.swift
//  
//
//  Created by Austin Chen on 2017-08-04.
//
//

import Foundation
import CoreData

extension Q3Episode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Q3Episode> {
        return NSFetchRequest<Q3Episode>(entityName: "Q3Episode")
    }

    @NSManaged public var title: String?
    @NSManaged public var people: String?
    @NSManaged public var audioLocalURLStr: String?
    @NSManaged public var videoLocalURLStr: NSObject?
    @NSManaged public var duration: Float
    @NSManaged public var broadcastDate: NSDate?

}
