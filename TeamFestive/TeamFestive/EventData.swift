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
    private let key = "&apikey=cZkS7fkgZY5xuMVE6pAP6cc7PdJFZjYP"
    private let urlBase = "https://app.ticketmaster.com/discovery/v2/events.json?"
    private var dataTask:URLSessionDataTask? = nil
    var delegate:EventDataProtocol? = nil
    
    init(){
        
    }
    
    private func urlCompile(query:String) -> NSURL{
        let tempURL:String = urlBase + "city=" + query
        let URL_Key:String = tempURL + key
        let url:NSURL = NSURL(string: URL_Key)!
        print(url)
        return url
    }
    
    func getData(dataQuery: String){
        let url = urlCompile(query: dataQuery)
        let dataTask  = self.urlSession.dataTask(with: url as URL) { (data, reponse, error) -> Void in
            if error != nil{
                print(error!)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    if jsonResult != nil {
                        //print(jsonResult!)
                        let data = jsonResult?.value(forKey: "_embedded") as? NSDictionary
                        let cur  = data?.value(forKey: "events") as? NSArray
                        //print(data!)
                        print("cur")
                        //print(cur!.count)
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

