//
//  ThemesViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/14/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, UITableViewDelegate {
    var style = ["Been Together 2018", "Been Together 2015", "Been Together 2014", "Default Style", "Clear Style"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func changeSlideMenu(_ sender: Any) {
        slideMenuController()?.openSlideMenuLeft()
        print(UserDefaults.standard.integer(forKey: "checkmark"))
    }
    
}
extension ThemesViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return style.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckmarkCell", for: indexPath)
        cell.textLabel?.text = style[indexPath.row]
        if(indexPath.row == UserDefaults.standard.integer(forKey: "checkmark") ){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
            UserDefaults.standard.set(indexPath.row, forKey: "checkmark")
            tableView.reloadData()
        }
       

    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == UITableViewCell.EditingStyle.delete
//        {
//            style.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
}
