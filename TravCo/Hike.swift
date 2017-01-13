//
//  Hike.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/10/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Hike {
    
    // MARK: - Variables
    
    var key : String
    var capacity : Int
    var addedByUser : String
    var startsAt : String
    var cityOfStart : String
    var cityOfArrival : String
    var isAnimalAllowed : Bool
    var isMusicAllowed : Bool
    var isFull : Bool
    var isDone : Bool
    var itemReference : FIRDatabaseReference?
    
    // MARK: - Initializers
    
    init (key: String = "",
          capacity : Int,
          addedBy : String,
          startsAt : String,
          startCity : String,
          arrivalCity : String,
          animalAllowed : Bool,
          musicAllowed : Bool,
          full : Bool,
          done : Bool ) {
            self.key = key
            self.capacity = capacity
            self.addedByUser = addedBy
            self.startsAt = startsAt
            self.cityOfStart = startCity
            self.cityOfArrival = arrivalCity
            self.isAnimalAllowed = animalAllowed
            self.isMusicAllowed = musicAllowed
            self.isFull = full
            self.isDone = done
            self.itemReference = nil }
    
    init (snapshot : FIRDataSnapshot) {
        self.key = snapshot.key
        self.itemReference = snapshot.ref
        if let capacity = snapshot.value(forKey: "capacity") as? Int{
            self.capacity = capacity
            }else {self.capacity = 1}
        if let addedByUser = snapshot.value(forKey: "addedByUser") as? String{
            self.addedByUser = addedByUser
            }else{self.addedByUser = ""}
        if let startsAt = snapshot.value(forKey: "startsAt") as? String{
            self.startsAt = startsAt
            }else {self.startsAt = "01/01/2001"}
        if let cityOfArrival = snapshot.value(forKey: "cityOfArrival") as? String{
            self.cityOfArrival = cityOfArrival
            }else {self.cityOfArrival = ""}
        if let cityOfStart = snapshot.value(forKey: "cityOfStart") as? String{
            self.cityOfStart = cityOfStart
            }else {self.cityOfStart = ""}
        if let isAnimalAllowed = snapshot.value(forKey: "isAnimalAllowed") as? Bool{
            self.isAnimalAllowed = isAnimalAllowed
            }else {self.isAnimalAllowed = true}
        if let isMusicAllowed = snapshot.value(forKey: "isMusicAllowed") as? Bool{
            self.isMusicAllowed = isMusicAllowed
            }else {self.isMusicAllowed = true}
        if let isFull = snapshot.value(forKey: "isFull") as? Bool{
            self.isFull = isFull
            }else {self.isFull = false}
        if let isDone = snapshot.value(forKey: "isDone") as? Bool{
            self.isDone = isDone
            }else{self.isDone = false}
    }
    func uploadingForm() -> Any {
        return ["capacity" : self.capacity ,
                "addedByUser" : self.addedByUser,
                "startsAt": self.startsAt,
                "cityOfStart" : self.cityOfStart,
                "cityOfArrival" : self.cityOfArrival,
                "isAnimalAllowed" : self.isAnimalAllowed,
                "isMusicAllowed" : self.isMusicAllowed,
                "isFull" : self.isFull,
                "isDone" : self.isDone
        ]}
}
