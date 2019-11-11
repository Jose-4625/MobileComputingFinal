//
//  TicketData.swift
//  TeamFestive
//
//  Created by Jose Torres on 11/10/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit

//Key: cZkS7fkgZY5xuMVE6pAP6cc7PdJFZjYP
protocol EventDataProtocol {
    func responseDataHandler(data: NSDictionary);
    func responseError(mesage:String);
}

class EventData{
    private let urlSession = URLSession.shared;
    private let key = "apikey=cZkS7fkgZY5xuMVE6pAP6cc7PdJFZjYP"
    private let urlBase = "https://app.ticketmaster.com/discovery/v2/events.json?"
    private var dataTask:URLSessionDataTask? = nil
    var delegate:EventDataProtocol? = nil
    
    init(){
        
    }
    func getData(dataQuery: String){
        let url:NSURL = NSURL(string: dataQuery)!
        let dataTask  = self.urlSession.dataTask(with: url as URL){ (data, reponse, error) -> Void in
            if error != nil{
                print(error)
            }else{
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                }
            }
            
            
        }
        
    }
}

