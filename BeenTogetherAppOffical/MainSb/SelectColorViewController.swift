//
//  SelectColorViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/20/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker
class SelectColorViewController: UIViewController,Delegate {
    
    
    static let shared = SelectColorViewController()
    var str : String = ""
    func passString(_ strColor: String) {
        str = strColor
    }
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x:50, y: 150, width: 300, height: 400))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(colorPicker)
        colorPicker.setViewColor(.black)
    }
    
    @IBAction func onDisplayColor(_ sender: Any) {
        guard let selectColor = colorPicker.color else{
            return
        }
        UserDefaults.standard.set(StringFromUIColor(color: selectColor), forKey: str)
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let settingTable = sb.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        present(settingTable,animated: true)
    }
    
    func StringFromUIColor(color: UIColor) -> String {
        
        let components = color.cgColor.components
        if(components?.count == 4){
            return "\(components![0]) \(components![1]) \(components![2]) \(components![3])"
        }
        else{
            return "\(components![0]) \(components![1])"
        }
    }

}
protocol Delegate: class {
    func passString(_ strColor : String)
}
