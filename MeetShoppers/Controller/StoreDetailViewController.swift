//
//  StoreDetailViewController.swift
//  MeetShoppers
//
//  Created by Kevin Nguyen on 4/14/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import MapKit


class StoreDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let DEBUG = true
    // detailed view controller labels
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var storeImage: UIImageView!
    
    @IBOutlet weak var checkInButtonView: UIButton!
    @IBOutlet weak var myListbtn: UIButton!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    
    var stores: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DEBUG {
            print("Inside ViewDidLoad")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        // set the labels as an oval
        
        checkInButtonView.layer.cornerRadius = checkInButtonView.frame.height / 2
        myListbtn.layer.cornerRadius = myListbtn.frame.height / 2
        mapBtn.layer.cornerRadius = mapBtn.frame.height / 2
        chatBtn.layer.cornerRadius = chatBtn.frame.height / 2
        
        if let stores = stores {
            storeNameLabel.text = stores.name
            storeImage.af_setImage(withURL: stores.imageURL!)
            
        }
        storeImage.layer.cornerRadius = 20
        storeImage.clipsToBounds = true
        self.view.bringSubview(toFront: storeNameLabel);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkInButton(_ sender: Any) {
       
    }
    @IBAction func mapBtn(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapPopUpId") as! MapPopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if DEBUG {
            print("Inside cellForRowAt")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DEBUG {
            print("Inside number Of Rows in section")
        }
        return 1
    }
    @IBAction func chatButton(_ sender: Any) {
        let chatLogViewController = ChatLogViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogViewController.business = stores
        navigationController?.pushViewController(chatLogViewController, animated: true)
    }
}
