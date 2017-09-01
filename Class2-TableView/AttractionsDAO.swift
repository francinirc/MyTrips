//
//  AttractionsDAO.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 04/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import Foundation
import CoreData

struct AttractionDAO {
   
    static func searchAll() -> [Attraction] {
        var attractions = [Attraction]()
        let request: NSFetchRequest<Attraction> = Attraction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        
        /*
        let filter = "Ipanema"
        let predicate = NSPredicate(format: "name contains[c] %@", filter)
        request.predicate = predicate
        */
        
        do {
            try attractions = CoreDataManager.sharedManager().getContext().fetch(request)
            print("Total attractions = \(attractions.count)")
            
        } catch let error as NSError {
            print("Could not fetch! \(error)")
        }
        
        return attractions
    }
    
    /*
    static func getAllAttractions() -> [Attractions] {
        var attractions = [Attractions]()
        attractions.append(Attractions(name: "Taquaral", city: "Campinas", country: "Brasil", picture: "campinas"))
        
        attractions.append(Attractions(name: "Caracol Waterfall", city: "Canela", country: "Brasil", picture: "canela"))
        
        attractions.append(Attractions(name: "Chapada dos Guimaraes", city: "Chapada dos Guimarães", country: "Brasil", picture: "chapada"))
        
        attractions.append(Attractions(name: "Ipanema", city: "Rio de Janeiro", country: "Brasil", picture: "rio2"))
        
        attractions.append(Attractions(name: "Table Mountain", city: "Cape Town", country: "South Africa", picture: "tablemountain"))
        
        
        attractions.append(Attractions(name: "Buffelsfontein", city: "Cape Town", country: "South Africa", picture: "buffelsfontein"))
        
        
        attractions.append(Attractions(name: "Boulders Beach", city: "Cape Town", country: "South Africa", picture: "bouldersbeach"))
        
        attractions.append(Attractions(name: "Rodrigo de Freitas Lagoon", city: "Rio de Janeiro", country: "Brasil", picture: "rio1"))
        
        
        return attractions
    }
 */
    
}
