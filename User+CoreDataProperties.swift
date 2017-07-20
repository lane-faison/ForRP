//
//  User+CoreDataProperties.swift
//  WaterTracker
//
//  Created by Ryan Phillips on 7/20/17.
//  Copyright © 2017 Ryan Phillips. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var weight: Int16
    @NSManaged public var units: Int16

}
