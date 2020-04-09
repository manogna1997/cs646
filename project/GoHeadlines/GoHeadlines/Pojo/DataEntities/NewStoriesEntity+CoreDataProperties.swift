//
//  NewStoriesEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension NewStoriesEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewStoriesEntity> {
        return NSFetchRequest<NewStoriesEntity>(entityName: "NewStoriesEntity")
    }

    @NSManaged public var status: String?
    @NSManaged public var totalResults: Int64
    @NSManaged public var articles: NSSet?

}

// MARK: Generated accessors for articles
extension NewStoriesEntity {

    @objc(addArticlesObject:)
    @NSManaged public func addToArticles(_ value: ArticleEntity)

    @objc(removeArticlesObject:)
    @NSManaged public func removeFromArticles(_ value: ArticleEntity)

    @objc(addArticles:)
    @NSManaged public func addToArticles(_ values: NSSet)

    @objc(removeArticles:)
    @NSManaged public func removeFromArticles(_ values: NSSet)

}
