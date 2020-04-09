//
//  SourceElementEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceElementEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceElementEntity> {
        return NSFetchRequest<SourceElementEntity>(entityName: "SourceElementEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var sourceDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var category: String?
    @NSManaged public var language: String?
    @NSManaged public var country: String?

}
