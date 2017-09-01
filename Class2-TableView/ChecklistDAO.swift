//
//  Checklist.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 05/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import Foundation
import CloudKit

class ChecklistDAO {
    
    static func addRegister(with checklistItem: Checklist) {
        let container = CKContainer.default()
        let recordID = CKRecordID(recordName: checklistItem.item!)
        let record = CKRecord(recordType: "Checklist", recordID: recordID)
        
        container.publicCloudDatabase.fetch(withRecordID: recordID) { (fetchedRecord, error) in
            if error == nil {
                print("This item was already registred!")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationErrorRegister"), object: nil)
                
            } else {
                
                if fetchedRecord == nil {
                    record["item"] = checklistItem.item! as CKRecordValue
                    record["quantity"] = checklistItem.quantity! as CKRecordValue
                    
                    container.publicCloudDatabase.save(record) {  _, error in
                        DispatchQueue.main.async {
                            if let error = error {
                                print("CloudKit error: ", error.localizedDescription)
                                
                            } else {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationSuccessRegister"), object: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Search methods
    
    /*
     This method brings all registers at once
     */
    static func searchAll() {
        let container = CKContainer.default()
        
        // passing "true" as parameter to bring all the existing registers
        let predicate = NSPredicate(value: true)
        
        // CKQuery is the search object we're using, it needs to know the record type and predicate to filter if necessary
        let query = CKQuery(recordType: "Checklist", predicate: predicate)
        
        
        
        // to run the query we need to work with blocks, because it can take a few seconds to run
        container.publicCloudDatabase.perform(query, inZoneWith: nil) { (results, error) -> Void in
            if error != nil {
                print("Network error: ", error!)
                
            } else {
                for result in results! {
                    let newItem = Checklist(item: result.value(forKey: "item") as! String, quantity: result.value(forKey: "quantity") as! Int)
                    checklistItems.append(newItem)
                }
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationSuccessFetch"), object: checklistItems)
            }
        }
    }
    
    /*
     This method can be used to bring all registers by chunck; usually you will do this if you have too many data
     */
    static func searchAllInBlocks() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Checklist", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        
        var attractionRecords: [CKRecord] = []
        operation.recordFetchedBlock = { record in
            attractionRecords.append(record)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            print(attractionRecords.count)
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    static func searchByParameter() {
        // The predicate self contains %@ means "look for this value in every key that contains text".
        let predicate = NSPredicate(format: "self contains %@", "charger")
        let query = CKQuery(recordType: "Checklist", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        
        var attractionRecords: [CKRecord] = []
        operation.recordFetchedBlock = { record in
            attractionRecords.append(record)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            print(attractionRecords.count)
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }

}
