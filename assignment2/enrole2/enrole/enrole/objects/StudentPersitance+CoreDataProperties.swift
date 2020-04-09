//
//  StudentPersitance+CoreDataProperties.swift
//  enrole
//
//  Created by Manogna Podishetty on 10/15/19.
//  Copyright © 2019 manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension StudentPersitance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentPersitance> {
        return NSFetchRequest<StudentPersitance>(entityName: "StudentPersitance")
    }

    @NSManaged public var studentname: String?
    @NSManaged public var email: String?
    @NSManaged public var redid: String?
    @NSManaged public var refid: Int64
    @NSManaged public var classSelected: NSSet?

}

// MARK: Generated accessors for classSelected
extension StudentPersitance {

    @objc(addClassSelectedObject:)
    @NSManaged public func addToClassSelected(_ value: ClassInfo)

    @objc(removeClassSelectedObject:)
    @NSManaged public func removeFromClassSelected(_ value: ClassInfo)

    @objc(addClassSelected:)
    @NSManaged public func addToClassSelected(_ values: NSSet)

    @objc(removeClassSelected:)
    @NSManaged public func removeFromClassSelected(_ values: NSSet)

}
