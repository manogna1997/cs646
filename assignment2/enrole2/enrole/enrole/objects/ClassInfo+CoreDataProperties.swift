//
//  ClassInfo+CoreDataProperties.swift
//  enrole
//
//  Created by Manogna Podishetty on 10/15/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension ClassInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassInfo> {
        return NSFetchRequest<ClassInfo>(entityName: "ClassInfo")
    }

    @NSManaged public var number: String?
    @NSManaged public var title: String?
    @NSManaged public var room: String?
    @NSManaged public var time: String?
    @NSManaged public var id: Int64

}
