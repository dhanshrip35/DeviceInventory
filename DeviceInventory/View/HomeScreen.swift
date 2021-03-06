//
//  HomeScreen.swift
//  DeviceInventory
//
//  Created by Dhanshri Pawar on 27/04/20.
//  Copyright © 2020 Dhanshri Pawar. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController, HomeScreenProtocol {
    
    private let homeScreenPresenter = HomeScreenPresenter()
    
    var user : String?
    
    @IBOutlet weak var adminButton: UIButton!
    
    @IBOutlet weak var employeeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //Set background image -
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        //To curve borders of button -
//        adminButton.layer.cornerRadius = 35.0
//        employeeButton.layer.cornerRadius = 35.0
        
        //To set HomeScreen as delegate to HomeScreenProtocol
        homeScreenPresenter.homeScreenDelegate = self

        
    }
    
    @IBAction func adminButtonClicked(_ sender: UIButton) {
        homeScreenPresenter.whenAdminButtonIsClicked()
    }
    
    @IBAction func employeeButtonPressed(_ sender: UIButton) {
        homeScreenPresenter.whenEmployeeButtonIsClicked()
    }
    
    //Method from HomeScreenProtocol
    func performSegue() {
        if homeScreenPresenter.user == .admin {
           user = "admin"
        }else {
            user = "employee"
        }
           performSegue(withIdentifier: "redirectToLoginPage", sender: self)
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let loginPage = segue.destination as! LoginPage
        loginPage.user = user
    }
    
}
