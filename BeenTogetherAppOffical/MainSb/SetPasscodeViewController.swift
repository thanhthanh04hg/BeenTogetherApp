//
//  LockViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/13/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import Realm
class SetPasscodeViewController: UIViewController {

    @IBOutlet weak var repeatPassTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        passTxt.isSecureTextEntry = true
        repeatPassTxt.isSecureTextEntry = true
        alertLbl.text = ""
    }
    
    @IBAction func setPassButton(_ sender: Any) {
        if(repeatPassTxt.text != "" && passTxt.text != ""){
            if(repeatPassTxt.text != passTxt.text){
                alertLbl.text = "Your passcode is not match "
            }
            else{
                let passModal = Modal()
                passModal.name = "Pass"
                passModal.text = passTxt.text!
                RealmService.shared.add(passModal.self, filter: "name CONTAINS 'Pass'")
                UserDefaults.standard.set(true, forKey: "setPass")
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        
 
    }
    
}
