//
//  FestivalListTableViewController.swift
//  TeamFestive
//
//  Created by Xia, Emily on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import MapKit

class FestivalListTableViewController: UITableViewController, EventDataProtocol, CLLocationManagerDelegate {
    
    var startCity : String = ""
    
    let locationManager = CLLocationManager()
    
    func responseDataHandler(data: NSDictionary) {
        let dat = data["_embedded"]! as! NSDictionary
        let events = dat["events"] as! NSArray
        DispatchQueue.main.async {
        
        for i in events{
            let d = i as? NSDictionary
            let name = d!["name"]! as! String
            let location = ((((d!["_embedded"] as! NSDictionary)["venues"]! as! NSArray)[0] as! NSDictionary)["address"] as! NSDictionary)["line1"]! as! String
            let Date = ((d!["dates"]! as! NSDictionary)["start"] as! NSDictionary)["localDate"]! as! String
            let priceMin:String
            let priceMax:String
            if (d!["priceRanges"] != nil){
                priceMin = String(((d!["priceRanges"]! as! NSArray)[0] as! NSDictionary)["min"]! as! Float)
                priceMax = String(((d!["priceRanges"]! as! NSArray)[0] as! NSDictionary)["max"]! as! Float)
            }else{
                priceMin = "Unavailable"
                priceMax = "Unavailable"
            }
            //print(priceMin)
            //print(priceMax)
            let price = "\(priceMin) - \(priceMax) USD"
            let venue = (((d!["_embedded"] as! NSDictionary)["venues"]! as! NSArray)[0] as! NSDictionary)["name"] as! String
            //print(venue)
            let desc = d!["id"]! as! String
            let website = d!["url"]! as! String
            print("web",website)
            let Image = ((d!["images"]! as! NSArray)[9] as! NSDictionary)["url"] as! String
            let _temp = Festivals(name: name, location: location, Date: Date, price: price, venue: venue, desc: desc, Website: website, Image: Image)
            self.eventlist += [_temp]
        }
        print("response OK")
        self.tableView.reloadData()
        }
    }
    
    func responseError(message: String) {
        print("response ERROR")
    }
    
    var eventlist:[Festivals] = [];
    var dataSession = EventData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        
        self.dataSession.delegate = self
        self.dataSession.getData(dataQuery: "Austin")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundColor = .oceanBlue

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(eventlist.count)
        return eventlist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FestivalCell", for: indexPath) as? FestivalCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of FestivalCellTableViewCell.")
        }
        
        if !(cell.backgroundView is ListCellBackground) {
          cell.backgroundView = ListCellBackground()
        }
            
        if !(cell.selectedBackgroundView is ListCellBackground) {
          cell.selectedBackgroundView = ListCellBackground()
        }


        let curFest = eventlist[indexPath.row]

        
        cell.ListName.text = curFest.name
        cell.ListDate.text = curFest.Date
        cell.ListImage.image = curFest.getImage()
        cell.textLabel!.textColor = .matteGrey

        return cell
    }

    func save(name: String, desc: String, image: Data, date:String, price:String, venue:String, website:String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
        let Event = NSManagedObject(entity: entity, insertInto: managedContext)
        //3
        Event.setValue(name, forKeyPath: "name")
        Event.setValue(desc, forKey: "desc")
        Event.setValue(image, forKey: "image")
        Event.setValue(date, forKey: "date")
        Event.setValue(price, forKey: "price")
        Event.setValue(venue, forKey: "venue")
        Event.setValue(website, forKey: "website")
        do {
        try managedContext.save()
        //self.tableView.reloadData()
        } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
        }
        
    }

    //MARK: Location
        //CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /*for location in locations {
            print(location)
        }*/
        
        let authStatus = CLLocationManager.authorizationStatus()
        let inUse = CLAuthorizationStatus.authorizedWhenInUse
        let always = CLAuthorizationStatus.authorizedAlways
        
        if authStatus == inUse || authStatus == always {
            if let lastLocation = self.locationManager.location {
                let geocoder = CLGeocoder()
                    
                //Look up the coordinates and pass it to the completion handler
                geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                    if error == nil {
                        let firstLocation = placemarks?[0]
                        //WILL NEED TO SEARCH THIS LOCATION ON LOAD
                        self.startCity = firstLocation?.locality ?? ""
                        print(self.startCity)
                        self.startCity = self.startCity.replacingOccurrences(of: " ", with: "+")
                        print(self.startCity)
                        self.dataSession.getData(dataQuery: self.startCity)
                        
                        //firstLocation?.country ?? ""
                    } else {
                     //An error occurred during geocoding
                        print("error")
                    }
                })
            } else {
                //No location available
                print("no location")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    //MARK: Navigation
    @IBAction func unwindToListView(segue: UIStoryboardSegue){
        
    }
    

}
