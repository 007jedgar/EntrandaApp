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
import FirebaseStorage
import Kingfisher



class CityGuideTableViewController: UITableViewController {

    var cities = [City]()
    var ref: FIRDatabaseReference!
    var practiceCities = [String]()
    // MARK :: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        sendToCityDB()
        readDB()
        self.tableView.reloadData()
    }

    //Sends city
    func sendToCityDB() {
        ref = FIRDatabase.database().reference()
        
        let rndmRef = self.ref.child("City").child("City Name")
        var count: Int = 0
        for city in cities {
        
        let cityName = rndmRef.child("city\(count)").child("City Name")
        cityName.setValue(city.cityTitle)
        count += 1
        }
    }

    //For Reading from database and checking for updates
    func readDB() {
        ref = FIRDatabase.database().reference()
        let cityRef = ref.child("City").child("City Name")
        
        cityRef.observe(FIRDataEventType.value, with: { (snapshot: FIRDataSnapshot) in
            let cityInfo = snapshot.value as! [String: Any]
            
            self.cities.removeAll()
            for i in 0...5 {
            let eachCity = cityInfo["city\(i)"] as! [String: Any]
            let title = (eachCity["City Name"]!)
            let cityPic = (eachCity["City ImgURL"]!)
                let city = City(cityTitle: title as! String, cityId: "city\(i)", imgURL: cityPic as! String)
                self.cities.append(city)
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    //For future "add city" button
    //adds city to city class
    func makeCity(cityName: String) {
        
        let city = City()
        city.cityTitle = cityName
        cities.append(city)
        sendToCityDB()
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell

        let city = cities[indexPath.row]
        let citytitle = city.cityTitle
        
        cell.cityLabel?.text = citytitle
        DispatchQueue.global().async {
            
            let imgURL = city.imgURL
            DispatchQueue.main.async {
                let url = URL(string: imgURL)
                cell.cityImgView.kf.setImage(with: url)
            }
        }
        return cell
    }
    //sends city object to GuideTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier) == "CityToGuide" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
            let cityObj = self.cities[indexPath.row]
            let vc  = segue.destination as! GuideTableViewControl
            //let vc = top.topViewController as! GuideTableViewControl
                vc.city = cityObj
                vc.title = cityObj.cityTitle
            }
        }
    }
}
