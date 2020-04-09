//
//  AppTagData+CoreDataProperties.swift
//  PostSocial
//
//  Created by Abhilash Keerthi on 11/28/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension AppTagData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppTagData> {
        return NSFetchRequest<AppTagData>(entityName: "AppTagData")
    }

    @NSManaged public var hashTags: NSObject?
    @NSManaged public var nickNames: NSObject?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var posts: AddPostPersist?

}
