//
//  SavedListTableViewController.swift
//  TeamFestive
//
//  Created by Xia, Emily on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit
import CoreData

class SavedListTableViewController: UITableViewController {
    var SavedEvents:[NSManagedObject] = []
    
    @IBOutlet weak var savedLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadSavedData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundColor = .fadedPink
        savedLabel.backgroundColor = .oceanBlue
    }

    //MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SavedEvents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as? SavedCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of SavedCellTableViewCell.")
        }
        
        if !(cell.backgroundView is ListCellBackground) {
          cell.backgroundView = ListCellBackground()
        }
            
        if !(cell.selectedBackgroundView is ListCellBackground) {
          cell.selectedBackgroundView = ListCellBackground()
        }

        let Event = SavedEvents[indexPath.row]
        cell.SavedName.text = Event.value(forKeyPath: "name") as? String
        cell.SavedDate.text = String(Event.value(forKeyPath: "date") as! String)
        cell.SavedImage.image = UIImage(data: Event.value(forKeyPath: "image") as! Data)
        
        cell.textLabel!.textColor = .matteGrey
        
        return cell
    }
    
    //MARK: Own Methods
    func loadSavedData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")

        do {
            SavedEvents = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func delete(selectedObject:NSManagedObject, selectedObjectID: Int){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Event", in: managedContext)!
        managedContext.delete(selectedObject)
        SavedEvents.remove(at: selectedObjectID)

        print("deleted")
        
        do {
            try managedContext.save()
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Navigation
    @IBAction func unwindToSavedView(segue: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.destination is ViewController{
            let vc = segue.destination as? ViewController
            let cellidx = self.tableView.indexPathForSelectedRow!
            let selectedData = self.SavedEvents[cellidx.row]
            let cell = self.tableView.cellForRow(at: cellidx) as! SavedCellTableViewCell
            //name: String, _class:String, level:Int, image:UIImage, currentHP:Int, totalHP:Int, APM:Float
            vc!.selectedData = selectedData
            vc!.selectedDataID = cellidx.row
            vc!.date = selectedData.value(forKeyPath: "date") as? String
            vc!.desc = selectedData.value(forKeyPath: "desc") as? String
            vc!.img = UIImage(data: selectedData.value(forKeyPath: "image") as! Data)
            vc!.name = selectedData.value(forKeyPath: "name") as? String
            vc!.price = selectedData.value(forKeyPath: "price") as? String
            vc!.site = selectedData.value(forKeyPath: "website") as? String
            vc!.venue = selectedData.value(forKeyPath: "venue") as? String
        }
    }
}
