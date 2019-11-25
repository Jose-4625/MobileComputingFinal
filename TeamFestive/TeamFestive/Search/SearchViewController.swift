//
//  SearchViewController.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/13/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit
import os.log

class SearchViewController: UIViewController, UITextFieldDelegate, EventDataProtocol {
    // MARK: Properties
    private var dataSession = EventData()
    var city: String = ""
    
    @IBOutlet weak var cityField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    private let key = "apikey=cZkS7fkgZY5xuMVE6pAP6cc7PdJFZjYP"
    private let urlBase = "https://app.ticketmaster.com/discovery/v2/events.json?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Formatting
    @IBAction func search(_ sender: UIButton) {
        
        self.cityField.resignFirstResponder()
        //self.stateField.resignFirstResponder()
        
        // Needs to be ?q={city},{state} and ?q={zipcode}
        var processedURL: String
        //let (newState, zipFlag) = convertText(text: stateField.text!)
        let (newCity, _) = convertText(text: cityField.text!)
        let justCity = convertText(text: cityField.text!)
        
        /*if zipFlag {
            processedURL = newState
        }
        else {
            processedURL = "city=\(newCity)&stateCode=\(newState)&"
        }*/
    
        //let completeURL = urlBase + processedURL + key
        self.city = newCity
        print(self.city)
        self.performSegue(withIdentifier: "unwind", sender: searchButton)
        //self.dataSession.getData(dataQuery: justCity)
        //print(completeURL)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func convertText(text: String) -> (String, Bool) {
        var zipFlag = false
        var newText: String = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        newText = newText.replacingOccurrences(of: " ", with: "+")
        zipFlag = (CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: newText))) && (text.count == 5)
        
        print("Processed Text: \(newText)\nZip Flag: \(zipFlag)")
        return (newText, zipFlag)
    }
    
    func responseDataHandler(data: NSDictionary) {
        
    }
    
    func responseError(message:String) {
        
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button === searchButton else {
             os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
             return
        }
        
        if segue.destination is FestivalListTableViewController
        {
            let vc = segue.destination as? FestivalListTableViewController
            vc!.dataSession.getData(dataQuery: String(self.city))
        }
    }
}
