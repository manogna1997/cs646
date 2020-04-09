//
//  SourcesEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension SourcesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourcesEntity> {
        return NSFetchRequest<SourcesEntity>(entityName: "SourcesEntity")
    }

    @NSManaged public var status: String?
    @NSManaged public var sources: NSSet?

}

// MARK: Generated accessors for sources
extension SourcesEntity {

    @objc(addSourcesObject:)
    @NSManaged public func addToSources(_ value: SourceElementEntity)

    @objc(removeSourcesObject:)
    @NSManaged public func removeFromSources(_ value: SourceElementEntity)

    @objc(addSources:)
    @NSManaged public func addToSources(_ values: NSSet)

    @objc(removeSources:)
    @NSManaged public func removeFromSources(_ values: NSSet)

}
