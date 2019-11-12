//
//  FestivalClass.swift
//  TeamFestive
//
//  Created by Jose Torres on 11/11/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

class Festivals{
    var location:String = ""
    var name:String = ""
    var Date:String = ""
    var price:String = ""
    var venue:String = ""
    var desc:String = ""
    var WebSite:String = ""
    var imageURL:NSURL;
    init(name:String,location:String, Date:String,price:String,venue:String,desc:String,Website:String, Image:String) {
        self.name = name
        self.location = location
        self.Date = Date
        self.price = price
        self.venue = venue
        self.desc = desc
        self.WebSite = Website
        self.imageURL = NSURL(string: Image)!
    }
    func getImage() -> UIImage{
        let url:URL = self.imageURL as URL
        let imageData = try? Data(contentsOf: url)
        return UIImage(data: imageData!)!
    }
    
}
