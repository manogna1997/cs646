//
//  SourceEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceEntity> {
        return NSFetchRequest<SourceEntity>(entityName: "SourceEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
