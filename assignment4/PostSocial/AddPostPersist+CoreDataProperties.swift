//
//  AddPostPersist+CoreDataProperties.swift
//  PostSocial
//
//  Created by Abhilash Keerthi on 11/28/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension AddPostPersist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddPostPersist> {
        return NSFetchRequest<AddPostPersist>(entityName: "AddPostPersist")
    }

    @NSManaged public var hashtags: NSObject?
    @NSManaged public var text: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}
