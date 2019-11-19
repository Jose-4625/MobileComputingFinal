//
//  ViewController.swift
//  TeamFestive
//
//  Created by Jose Torres on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit
//import OSLog
class ViewController: UIViewController{

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var siteLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var date:String!;
    var desc:String!;
    var img:UIImage!;
    var name:String!;
    var price:String!;
    var site:String!;
    var venue:String!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dateLabel.text = date
        self.descLabel.text = desc
        self.image.image = img
        self.nameLabel.text = name
        self.priceLabel.text = price
        self.siteLabel.text = site
        self.venueLabel.text = venue
        
        
    }
    //MARK: ADD THE PREPARE CODE (Check for changes in the above code... i don't remember if i made any changes)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        
        let vc = segue.destination as? FestivalListTableViewController
        vc?.tableView.reloadData()
        let imgData = self.image.image!.jpegData(compressionQuality: 1.0)
        vc?.save(name: self.nameLabel.text!, desc: self.descLabel.text!, image:imgData!, date: self.dateLabel.text!, price: self.priceLabel.text!, venue: self.venueLabel.text!, website: self.siteLabel.text!)
        
    }
    


}

