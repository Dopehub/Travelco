//
//  File.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/10/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    var userUid : String
    var displayName : String
    var email : String
    
    init(userData : FIRUser) {
        
        self.userUid = userData.uid
        if let mail = userData.email {
        
            self.email = mail
            
        } else {
           
            self.email = ""
        }
        
        if let dispName = userData.displayName {
            
            self.displayName = dispName
        
        } else {
            
            self.displayName = ""
        }
        
    }
    
    func uploadToJson() -> Any {
        
        return ["email" : self.email,
                "displayName" : self.displayName
        ]
        
    }
}
