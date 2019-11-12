//
//  ViewController.swift
//  TeamFestive
//
//  Created by Jose Torres on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var siteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let event3 = Festivals(name: "Austin Music Video Festival", location: "700 Lavaca St, Austin, TX", Date: "Dec 10th", price: "$35 – $185", venue: "Alamo Drafthouse Cinema Ritz", desc: "Since launching in 2015, AMVF has become the biggest music video festival on the planet, fearlessly showcasing cutting-edge independent artists alongside the likes of Flaming Lips, Kesha, Spike Jonze, and Beyoncé.", Website: "https://www.amvfest.com/", Image: "https://assets.simpleviewinc.com/simpleview/image/fetch/c_fill,h_357,q_75,w_537/https://assets.simpleviewinc.com/simpleview/image/upload/crm/austin/AMV10_c21488b5-065c-7969-ca77c539342d817d.jpg")
        self.dateLabel.text = event3.Date
        self.descLabel.text = event3.desc
        self.image.image = event3.getImage()
        self.nameLabel.text = event3.name
        self.priceLabel.text = event3.price
        self.siteLabel.text = event3.WebSite
        self.venueLabel.text = event3.venue
        
    }


}

