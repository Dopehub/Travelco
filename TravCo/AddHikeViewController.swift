//
//  AddHikeViewController.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/13/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddHikeViewController: UIViewController {
    
    var dbRef : FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("Hikes")

        
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let aHike = Hike(capacity: 2, addedBy: "imad", startsAt: "12/12/2013", startCity: "Sidi Kacem", arrivalCity: " Casa Blanca ", animalAllowed: true , musicAllowed: true, full: false, done: false)
        dbRef.childByAutoId().setValue(aHike.uploadingForm())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
