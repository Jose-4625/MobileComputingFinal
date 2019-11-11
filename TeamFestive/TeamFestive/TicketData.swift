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
    func responseError(message:String);
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
        let url = NSURL(string: dataQuery)!
        let dataTask  = self.urlSession.dataTask(with: url as URL) { (data, reponse, error) -> Void in
            if error != nil{
                print(error!)
            }else{
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        //print(jsonResult!)
                        let data = jsonResult?.value(forKey: "data") as? NSDictionary
                        let cur  = data?.value(forKey: "current_condition") as? NSArray
                        //print(data!)
                        //print(currentData)
                        if data != nil && cur != nil{
                            self.delegate?.responseDataHandler(data: jsonResult!)
                        } else {
                            self.delegate?.responseError(message: "Fake data not found")
                        }
                        
                        
                    }
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
}

