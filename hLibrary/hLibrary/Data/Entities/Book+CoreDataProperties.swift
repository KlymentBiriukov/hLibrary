//
//  Book+CoreDataProperties.swift
//  hLibrary
//
//  Created by Kliment Biryukov on 04.07.18.
//  Copyright © 2018 Biriukovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var bookTitle: String?
    @NSManaged public var id: Int32

}
