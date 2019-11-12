//
//  SavedListTableViewController.swift
//  TeamFestive
//
//  Created by Xia, Emily on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class SavedListTableViewController: UITableViewController {
    let event3 = Festivals(name: "Austin Music Video Festival", location: "700 Lavaca St, Austin, TX", Date: "Dec 10th", price: "$35 – $185", venue: "Alamo Drafthouse Cinema Ritz", desc: "Since launching in 2015, AMVF has become the biggest music video festival on the planet, fearlessly showcasing cutting-edge independent artists alongside the likes of Flaming Lips, Kesha, Spike Jonze, and Beyoncé.", Website: "https://www.amvfest.com/", Image: "https://assets.simpleviewinc.com/simpleview/image/fetch/c_fill,h_357,q_75,w_537/https://assets.simpleviewinc.com/simpleview/image/upload/crm/austin/AMV10_c21488b5-065c-7969-ca77c539342d817d.jpg")
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath) as? SavedCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of SavedCellTableViewCell.")
        }
        
        cell.SavedName.text = event3.name
        cell.SavedDate.text = event3.Date
        cell.SavedImage.image = event3.getImage()

        return cell
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
