//
//  LockViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/13/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {

    @IBOutlet weak var alertLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        alertLbl.text = ""
        passTxt.isSecureTextEntry = true
    }
    
    @IBAction func onDisplayMainView(_ sender: Any) {
        if(passTxt.text == RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Pass'").text){
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let slideView = sb.instantiateViewController(withIdentifier: "SlideMenuViewController") as! SlideMenuViewController
//            self.navigationController?.pushViewController(slideView, animated: true)
            present(slideView,animated: true)
        }
        else {
            alertLbl.text = "Your passcode is not true"
        }
    }
    
    
}
