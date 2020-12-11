//
//  TitleViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/6/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController , TitleDelegate  {
    @IBOutlet var text: UITextField!
    @IBOutlet var changeTitleLabel: UILabel!
    var strLabel : String = ""
    var strText : String = ""
    var onDisplayText : ((String)->())?
    func passLabel(_ label : String ,_ text : String){
        strLabel = label
        strText = text
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTitleLabel.text = strLabel
        text.text = strText
        
    }
    
    @IBAction func ok(_ sender: Any) {
        if (text.text != ""){
            
            if(UserDefaults.standard.bool(forKey: "isTitle")==true){
                onDisplayText?(text.text!)
                UserDefaults.standard.set(text.text, forKey: "Title")
            }
            else{
                onDisplayText?(text.text!)
                UserDefaults.standard.set(text.text, forKey: "Bottom")
            }
            
            self.view.removeFromSuperview()
        }
    }
    @IBAction func cancel(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
}

protocol TitleDelegate : class {
    func passLabel(_ label : String , _ text : String)
}
