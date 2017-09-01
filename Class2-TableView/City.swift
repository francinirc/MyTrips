//
//  City.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 05/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import Foundation
import CoreData

class City: NSManagedObject {
    
    convenience init() {
        let classStringName = String(describing: City.self)
        let entityDescription = NSEntityDescription.entity(forEntityName: classStringName, in: CoreDataManager.sharedManager().getContext())
        
        self.init(entity: entityDescription!, insertInto: CoreDataManager.sharedManager().getContext())
    }

    
}
