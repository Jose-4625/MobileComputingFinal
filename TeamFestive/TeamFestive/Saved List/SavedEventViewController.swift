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

class SavedEventViewController: UIViewController, WKNavigationDelegate {
    //MARK: Properties
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    var date: String!
    var desc: String!
    var img: UIImage!
    var name: String!
    var price: String!
    var site: String!
    var venue: String!
    var selectedData: NSManagedObject!
    var selectedDataID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dateLabel.text = date
        self.image.image = img
        self.nameLabel.text = name
        self.priceLabel.text = price

        if self.priceLabel.text == Optional("Unavailable - Unavailable USD") {
            self.priceLabel.text = "See Below for Ticket Prices" }
        else {
            self.priceLabel.text = price }
        
        self.venueLabel.text = venue
        self.webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: self.site)!)
        self.webView.load(request)
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
