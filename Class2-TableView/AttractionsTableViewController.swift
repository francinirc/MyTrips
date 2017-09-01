//
//  AttractionsTableViewController.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 04/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import UIKit

class AttractionsTableViewController: UITableViewController {

    var attractions = [Attraction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attractions = AttractionDAO.searchAll()
        
        if attractions.count == 0 {
            fillDatabase()
            attractions = AttractionDAO.searchAll()
        }
        
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return attractions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attractionCell", for: indexPath)
        
        if let attractionCell = cell as? AttractionTableViewCell {
            attractionCell.nameLabel.text = attractions[indexPath.row].name
            attractionCell.cityLabel.text = attractions[indexPath.row].city?.name
            attractionCell.countryLabel.text = attractions[indexPath.row].city?.country
            
            if let image = attractions[indexPath.row].picture {
                attractionCell.pictureImageView.image = UIImage(named: image)
            }
            
            return attractionCell
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            delete(attraction: attractions[indexPath.row])
            attractions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let detailsViewController = segue.destination as? DetailsViewController {
            if let index = tableView.indexPathForSelectedRow?.row {
                let attraction = attractions[index]
                detailsViewController.attraction = attraction
            }
        }
        
    }
    
    // MARK: - Database methods

    private func fillDatabase() {
        // Attraction 1
        let attraction = Attraction()
        attraction.name = "Table Mountain"
        attraction.picture = "tablemountain"
        
        let cityCapeTown = City()
        cityCapeTown.name = "Cape Town"
        cityCapeTown.country = "South Africa"
        
        attraction.city = cityCapeTown

        
        // Attraction 2
        let attraction2 = Attraction()
        attraction2.name = "Boulders Beach"
        attraction2.picture = "bouldersbeach"
        
        attraction2.city = cityCapeTown
        
        
        // Attraction 3
        let attraction3 = Attraction()
        attraction3.name = "Ipanema"
        attraction3.picture = "rio2"
        
        let cityRio = City()
        cityRio.name = "Rio de Janeiro"
        cityRio.country = "Brasil"
        
        attraction3.city = cityRio
        
        CoreDataManager.sharedManager().saveContext()
    }
    
    private func delete(attraction: Attraction) {
        CoreDataManager.sharedManager().getContext().delete(attraction)
        CoreDataManager.sharedManager().saveContext()
    }
    
}
