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
    let event3 = Festivals(name: "Austin Music Video Festival", location: "700 Lavaca St, Austin, TX", Date: "Dec 10th", price: "$35 – $185", venue: "Alamo Drafthouse Cinema Ritz", desc: "Since launching in 2015, AMVF has become the biggest music video festival on the planet, fearlessly showcasing cutting-edge independent artists alongside the likes of Flaming Lips, Kesha, Spike Jonze, and Beyoncé.", Website: "https://www.amvfest.com/", Image: "https://assets.simpleviewinc.com/simpleview/image/fetch/c_fill,h_357,q_75,w_537/https://assets.simpleviewinc.com/simpleview/image/upload/crm/austin/AMV10_c21488b5-065c-7969-ca77c539342d817d.jpg")
    var SavedEvents:[NSManagedObject] = []
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
    }

    // MARK: - Table view data source

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
    func loadSavedData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Event")
        //3
        do {
            SavedEvents = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.destination is ViewController{
            let vc = segue.destination as? ViewController
            let cellidx = self.tableView.indexPathForSelectedRow!
            let selecedData = self.SavedEvents[cellidx.row]
            let cell = self.tableView.cellForRow(at: cellidx) as! SavedCellTableViewCell
            //name: String, _class:String, level:Int, image:UIImage, currentHP:Int, totalHP:Int, APM:Float
            vc!.date = selecedData.value(forKeyPath: "date") as? String
            vc!.desc = selecedData.value(forKeyPath: "desc") as? String
            vc!.img = UIImage(data: selecedData.value(forKeyPath: "image") as! Data)
            vc!.name = selecedData.value(forKeyPath: "name") as? String
            vc!.price = selecedData.value(forKeyPath: "price") as? String
            vc!.site = selecedData.value(forKeyPath: "website") as? String
            vc!.venue = selecedData.value(forKeyPath: "venue") as? String
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
