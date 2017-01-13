//
//  DidLoginTableViewController.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/10/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DidLoginTableViewController: UITableViewController {
    
    // MARK: - Variables
    var dbreference : FIRDatabaseReference!
    var hikes = [Hike]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbreference = FIRDatabase.database().reference()
   
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
