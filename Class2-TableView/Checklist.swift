//
//  Checklist.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 06/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import Foundation

public var checklistItems = [Checklist]()

public class Checklist {
    
    var item: String?
    var quantity: Int?
    
    init(item: String, quantity: Int) {
        self.item = item
        self.quantity = quantity
    }
}
