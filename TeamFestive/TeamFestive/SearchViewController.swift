//
//  SearchViewController.swift
//  TeamFestive
//
//  Created by Denis Bowen on 11/13/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController, UITextFieldDelegate, EventDataProtocol {

    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!

    private let key = "apikey=cZkS7fkgZY5xuMVE6pAP6cc7PdJFZjYP"
    private let urlBase = "https://app.ticketmaster.com/discovery/v2/events.json?"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Variables
    private var dataSession = EventData()
    
    // MARK: Formatting
    @IBAction func search() {
        
        self.cityField.resignFirstResponder()
        self.stateField.resignFirstResponder()
        
        // Needs to be ?q={city},{state} and ?q={zipcode}
        var processedURL: String
        let (newState, zipFlag) = convertText(text: stateField.text!)
        let (newCity, _) = convertText(text: cityField.text!)

        if zipFlag {
            processedURL = newState
        }
        else {
            processedURL = "city=\(newCity)&stateCode=\(newState)&"
        }
    

        self.dataSession.getData(dataQuery: urlBase + processedURL + key)
        print(urlBase + processedURL + key)
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
    



}
