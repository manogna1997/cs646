//
//  SettingEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension SettingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingEntity> {
        return NSFetchRequest<SettingEntity>(entityName: "SettingEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var category: String?
    @NSManaged public var sources: String?

}
