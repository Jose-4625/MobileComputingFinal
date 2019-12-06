//
//  SavedEventViewController.swift
//  TeamFestive
//
//  Created by Xia, Emily on 12/3/19.
//  Copyright © 2019 Jose Torres. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import EventKit

class SavedEventViewController: UIViewController, WKNavigationDelegate {
    //MARK: Properties
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    @IBOutlet weak var calendarButton: UIButton!
    
    var date: String!
    var desc: String!
    var img: UIImage!
    var name: String!
    var price: String!
    var site: String!
    var venue: String!
    var selectedData: NSManagedObject!
    var selectedDataID: Int!
    
    var masterList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateLabel.text = date
        masterList.append(dateLabel.text!)
        self.image.image = img
        self.nameLabel.text = name
        masterList.append(nameLabel.text!)
        self.priceLabel.text = price

        if self.priceLabel.text == Optional("Unavailable - Unavailable USD") {
            self.priceLabel.text = "See Below for Ticket Prices" }
        else {
            self.priceLabel.text = price }
        
        self.venueLabel.text = venue
        self.webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: self.site)!)
        self.webView.load(request)
        
        if EKEventStore.authorizationStatus(for: .event) == .denied {
            calendarButton.isHidden = true
        }
        else {
            calendarButton.isHidden = false
        }

     }
    @IBAction func createEvent(_ sender: Any) {
        
        let eventStore = EKEventStore()
        
        // 2
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            calendarButton.isHidden = false
        case .denied:
            calendarButton.isHidden = true
        case .notDetermined:
        // 3
            eventStore.requestAccess(to: .event, completion:
              {[weak self] (granted: Bool, error: Error?) -> Void in
                  if granted {
                    //self!.createCalendarEvent(store: eventStore)
                    self!.calendarButton.isHidden = false
                  } else {
                        self!.calendarButton.isHidden = true
                        print("Access denied")
                  }
            })
            default:
                print("Case default")
        }

        // 1
        let calendars = eventStore.calendars(for: .event)

        for calendar in calendars {
            // 2
            if calendar.title == "Calendar" {
                // 3
                let dateString = masterList[0]
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let startDate = dateFormatter.date(from: dateString)
                // 2 hours
                let endDate = startDate!.addingTimeInterval(24 * 60 * 60)

                // 4
                let event = EKEvent(eventStore: eventStore)
                event.calendar = calendar

                event.title = masterList[1]
                event.startDate = startDate
                event.endDate = endDate

                // 5
                do {
                    try eventStore.save(event, span: .thisEvent)
                    
                    let alertController = UIAlertController(title: "Event Added", message:
                        "Event successfully added to your Calendar!", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                    self.present(alertController, animated: true, completion: nil)
                }
                catch {
                   print("Error saving event in calendar")             }
                }
        }
    }
    
    //MARK: Web View
     func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
         print("webView:\(webView) didReceiveServerRedirectForProvisionalNavigation:\(String(describing: navigation))")
         print(webView.url!)
         self.webView.load( URLRequest(url: webView.url!))
     }
    
     func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         print("didCommitNavigation - content arriving?")
     }

     private func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
         print("didFailNavigation")
     }

     func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         print("didStartProvisionalNavigation \(String(describing: navigation))")
     }

     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         print("didFinishNavigation")
         
     }

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Trash button is pressed
        guard let button = sender as? UIBarButtonItem, button === trashButton else {
            return
        }

        let vc = segue.destination as? SavedListTableViewController
        vc?.tableView.reloadData()
        vc?.delete(selectedObject: selectedData, selectedObjectID: selectedDataID)
    }
}
