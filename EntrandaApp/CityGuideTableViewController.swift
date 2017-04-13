//
//  CityGuideTableViewController.swift
//  EntrandaApp
//
//  Created by Jonathan Edgar on 4/12/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class City {
    
    var cityTitle = String()
    var cityID = String()
    var imgURL = String()
}

class CityGuideTableViewController: UITableViewController {

    let cities = [City]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateCityTable()
        makeCity(cityName: "Houston")
    }


    func populateCityTable() {
        
        
        
    }
    
    func makeCity(cityName: String) {
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell

        let city = cities[indexPath.row]
        cell.cityLabel.text = city.cityTitle
        
        return cell
    }



}
