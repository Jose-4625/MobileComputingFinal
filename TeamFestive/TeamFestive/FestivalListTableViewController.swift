//
//  FestivalListTableViewController.swift
//  TeamFestive
//
//  Created by Xia, Emily on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class FestivalListTableViewController: UITableViewController {
    var mocklist:[Festivals] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let event1 = Festivals(name:"The Bloody Mary Festival",location: "Fair Market 1100 E 5th St Austin, TX 78702", Date: "Nov 17th", price: "$45-$60", venue: "Fair Market", desc: "From SOCO to East Austin, we’ve scoured ATX for the craftiest and most delicious Bloody Marys. We proudly present the SUNDAY FUNDAY BRUNCH PARTY of the year.", Website: "https://www.thebloodymaryfest.com/", Image: "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F63299433%2F1262800154%2F1%2Foriginal.20190603-152847?w=800&auto=compress&rect=0%2C23%2C1124%2C562&s=ed69163908b4f22e7a76ae09319ad83a")
        let event2 = Festivals(name: "Seismic Dance Event", location: "Austin American-Statesman 305 South Congress Ave. Austin, TX 78704", Date: "Nov 16th", price: "$139-$329", venue: "Austin American-Statesman", desc: "DJ Mag Best of North America nominee Seismic Dance Event is set to shake Texas and the national dance music scene this November 16th & 17th with the boutique festival’s much anticipated return, curated specifically for house, techno & underground music enthusiasts.", Website: "http://seismicdanceevent.com/", Image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU3V2gyTZsgOIFCgpUN95I-pk_-Vh_Nwq8_0oMq6qR9B2vMRRtV_zsNuW0ujBWmGQq5gjovJMa&s=10")
        let event3 = Festivals(name: "Austin Music Video Festival", location: "700 Lavaca St, Austin, TX", Date: "Dec 10th", price: "$35 – $185", venue: "Alamo Drafthouse Cinema Ritz", desc: "Since launching in 2015, AMVF has become the biggest music video festival on the planet, fearlessly showcasing cutting-edge independent artists alongside the likes of Flaming Lips, Kesha, Spike Jonze, and Beyoncé.", Website: "https://www.amvfest.com/", Image: "https://assets.simpleviewinc.com/simpleview/image/fetch/c_fill,h_357,q_75,w_537/https://assets.simpleviewinc.com/simpleview/image/upload/crm/austin/AMV10_c21488b5-065c-7969-ca77c539342d817d.jpg")
        let event4 = Festivals(name: "Cider Fest", location: "10609 Metric Blvd #108, Austin, TX 78758", Date: "Nov 16th", price: "$20", venue: "FairWeather Cider Co", desc: "Join us for the second Cider Fest, hosted by Fairweather Cider Co; the final party of a weeklong celebration of AUSTIN CIDER WEEK.", Website: "http://www.fairweathercider.com/", Image: "https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F77954515%2F298767677894%2F1%2Foriginal.20191023-183226?w=800&auto=compress&rect=0%2C0%2C2160%2C1080&s=7d662e6753d58cf83b4ed4d8e934a620")
        mocklist += [event1,event2,event3,event4]
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
        return mocklist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FestivalCell", for: indexPath) as? FestivalCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of FestivalCellTableViewCell.")
        }
        let curFest = mocklist[indexPath.row]
        
        cell.ListName.text = curFest.name
        cell.ListDate.text = curFest.Date
        cell.ListImage.image = curFest.getImage()
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
