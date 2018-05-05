//
//  ToDoViewController.swift
//  MeetShoppers
//
//  Created by Kevin Nguyen on 4/14/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

struct note {
    let title: String!
    let message: String!
}

class ToDoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var ref: DatabaseReference?
    var notes: [note] = []
    var noteFilter: [note] = []
    var noteData = [String: Any]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MADE IT INSIDE TODO VIEW CONTROLLER")
        self.title = "TODO"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNoteAction(_:)))
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        let userID = Firebase.Auth.auth().currentUser!.uid
        ref = Database.database().reference()
    ref?.child("users").child(userID).child("Notes").observe(.childAdded, with: {snapShot in
        
            //let messageV = snapShot.childSnapshot(forPath: titleV).value as! String
        let messageV = ""
        self.notes.append(note(title: snapShot.key as! String, message: snapShot.value as! String))
        self.tableView.reloadData()
        print("Title: ", snapShot.key)
        print("value: ", snapShot.value)
        
       })
        
        ref?.child("users").child(userID).child("Notes").observe(.childAdded, with: {(snapShot) in
          
        })
         noteFilter = notes
         self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    /*
     tableView.estimatedRowHeight = 100
     tableView.rowHeight = UITableViewAutomaticDimension
 */

    @IBAction func addNoteAction(_ sender: Any) {
        print("add Note action")
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupStoreID") as! ObjPopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        let todo = noteFilter[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.descriptionLabel.text = todo.message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        noteFilter = searchText.isEmpty ? notes : notes.filter { (item: note) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
        print("Made it to seaerch bar changes")
    }

}
