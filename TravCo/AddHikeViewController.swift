//
//  AddHikeViewController.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/13/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn

class AddHikeViewController: UIViewController , GIDSignInUIDelegate {
    
    // MARK: - Variables
    
    var addedby : String?
    var dbRef : FIRDatabaseReference!
    var areAnimalsAllowed : Bool!
    var isMusicAllowed : Bool!
    var StartCity : String?
    var toCity : String?
    var user: FIRUser?
    
    // MARK: - Outlets
    
    @IBOutlet weak var musicSwitch: UISwitch!
    @IBOutlet weak var animalSwitch: UISwitch!
    @IBOutlet weak var fromCityTF: UITextField!
    @IBOutlet weak var toCityTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBOutlet weak var nbrPlacesLabel: UILabel!
    
    // MARK: - Action outlets
    
    @IBAction func placeStepper(_ sender: UIStepper) {
        sender.maximumValue = 4
        sender.minimumValue = 1
        self.nbrPlacesLabel.text = String(Int(sender.value))
    }
    @IBAction func musicAllowedSwitchFlicked(_ sender: UISwitch) {
        self.isMusicAllowed = sender.isOn
    }
    @IBAction func animalsAllowedSwitchFlicked(_ sender: UISwitch) {
        self.areAnimalsAllowed = sender.isOn
    }
    // MARK: - Fuctions
    func checkUserStatus(){
        _ = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            if ((FIRAuth.auth()?.currentUser) != nil) {
                self.user = user
            }else{
                self.user = nil
            }
        }
    }
    override func viewDidLoad() {
        self.user = FIRAuth.auth()?.currentUser
        GIDSignIn.sharedInstance().uiDelegate = self
        super.viewDidLoad()
        self.animalSwitch.setOn(false, animated: true)
        self.musicSwitch.setOn(false, animated: true)
        self.areAnimalsAllowed = false
        self.isMusicAllowed = false
        dbRef = FIRDatabase.database().reference().child("Hikes")
        stepperValue.value = 1.0
        nbrPlacesLabel.text = String(Int(self.stepperValue.value))
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        checkUserStatus()
        let capacity = Int(self.stepperValue.value)
        if let addedBy = self.user {
            self.addedby = addedBy.uid
        }else{
            self.addedby = "unknown"
        }
        if let startCity = self.fromCityTF {
            if (startCity.text?.isEmpty)! {
                self.StartCity = " unspecified"
            }else{
                self.StartCity = startCity.text
            }
        }else {
            StartCity = "unspecified"
        }
        if let toCity = self.toCityTF {
            if (toCity.text?.isEmpty)! {
                self.toCity = " unspecified"
            }else{
                self.toCity = toCity.text
            }
        }else {
            self.toCity = "unspecified"
        }
        let aHike = Hike(capacity: capacity,
                         addedBy: self.addedby!,
                         startsAt: "12/12/2013",
                         startCity: self.StartCity!,
                         arrivalCity: self.toCity!,
                         animalAllowed: self.areAnimalsAllowed,
                         musicAllowed: self.isMusicAllowed,
                         full: false,
                         done: false)
        dbRef.childByAutoId().setValue(aHike.uploadingForm())
    }
    
    // MARK: - logOut
    
    @IBAction func LogoutPressed(_ sender: UIButton) {
        do{
        try FIRAuth.auth()?.signOut()
        } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
}
