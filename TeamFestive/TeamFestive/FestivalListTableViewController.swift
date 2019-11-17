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

class FestivalListTableViewController: UITableViewController, EventDataProtocol {
    
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
        self.dataSession.delegate = self
        self.dataSession.getData(dataQuery: "Austin")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        let curFest = eventlist[indexPath.row]
        
        cell.ListName.text = curFest.name
        cell.ListDate.text = curFest.Date
        cell.ListImage.image = curFest.getImage()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
