//
//  AppDelegate.swift
//  TravCo
//
//  Created by Imad Ajallal on 1/10/17.
//  Copyright © 2017 Imad Ajallal. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate {

    var window: UIWindow?
    var dbref: FIRDatabaseReference!

     // MARK: - Google Sign in Protocol
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error) != nil {
            print((error?.localizedDescription)!)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(
            withIDToken: authentication.idToken,
            accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if  error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            let jUser = User(userData: user!)
            
            self.dbref.child("users").child(jUser.userUid).setValue(jUser.uploadToJson())
            self.window?.rootViewController?.performSegue(withIdentifier: "LoggedInSegue", sender: nil)
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("loggedout?")
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.window?.rootViewController?.performSegue(withIdentifier: "LoggedOutSegue", sender: nil)
        print("did log out")
    }
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                        annotation: [:])
    }
    
    // MARK: - App States
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        self.dbref = FIRDatabase.database().reference()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
     
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
      
    }
    func applicationWillTerminate(_ application: UIApplication) {

    }
}

