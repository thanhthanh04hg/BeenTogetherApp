//
//  SwitchTableViewCell.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/1/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if(leftLabel.text == "Start From 1"){
            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "StartFrom1")
            }
            else {
                UserDefaults.standard.set(false,forKey: "StartFrom1")
            }
        }
        if(leftLabel.text == "Show year, month, day"){
            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "ShowYearMonthDay")
            }
            else {
                UserDefaults.standard.set(false,forKey: "ShowYearMonthDay")
            }
        }
        else{
            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "setPass")

            }
            else {
                UserDefaults.standard.set(false,forKey: "setPass")
            }
        }
        
    }
    
}
