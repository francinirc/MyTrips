//
//  DetailsViewController.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 05/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityCountryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var attraction: Attraction?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myAttraction = attraction {
            nameLabel.text = myAttraction.name
            cityCountryLabel.text = "\(myAttraction.city!.name!) - \(myAttraction.city!.country!)"
            descriptionLabel.text = "This is one of the best places to visit in \(myAttraction.city!.name!)! You should totally go!"
            
            if let picture = myAttraction.picture {
                pictureImageView.image = UIImage(named: picture)
            }
        }
        
    }

    
}
