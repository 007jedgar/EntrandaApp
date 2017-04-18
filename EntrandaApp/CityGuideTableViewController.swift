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

class City  {
    
    var cityTitle = String()
    var cityID = String()
    var imgURL = String()
    
    init(cityTitle: String, cityId: String, imgURL: String) {
        self.cityTitle = cityTitle
        self.cityID = cityId
        self.imgURL = imgURL
    }
    
    init(){
        
    }
}

class CityGuideTableViewController: UITableViewController {

    var cities = [City]()
    var ref: FIRDatabaseReference!

    // MARK :: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        makeCity(cityName: "Houston")
        makeCity(cityName: "Boston")
        makeCity(cityName: "San Francisco")
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
            
            for i in 0...2 {
            let eachCity = cityInfo["city\(i)"] as! [String: Any]
            let title = (eachCity["City Name"]!)
                print((eachCity["City ImgURL"]!))
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
        return cities.count
    }
    
    func downloadImgURL(url: String) -> UIImage {
        let session = URLSession(configuration: .default)
        let picURL = URL(string: url)
        var _img = UIImage()
        let downloadPicTask = session.dataTask(with: picURL!) { (data, response, error) in
            if let e = error {
                print("did not download...Error: \(e)")
            } else {
                
            let imageData = data
            let image = UIImage(data: imageData!)
            _img = image!
            }
        }
        downloadPicTask.resume()
        return _img
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell

        let city = cities[indexPath.row]
        print(city.cityTitle)
        var citytitle = city.cityTitle
        cell.cityLabel?.text = citytitle
        
        let imgURL = city.imgURL
//        let image = downloadImgURL(url: imgURL)
//        cell.cityImgView?.image = image
        return cell
    }
}
