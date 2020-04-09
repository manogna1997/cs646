//
//  ArticleEntity+CoreDataProperties.swift
//  GoHeadlines
//
//  Created by Manogna podishetty on 12/10/19.
//  Copyright © 2019 Manogna podishetty. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var content: String?
    @NSManaged public var source: SourceEntity?

}
