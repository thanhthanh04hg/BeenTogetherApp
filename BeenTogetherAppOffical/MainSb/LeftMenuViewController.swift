//
//  LeftMenuViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/14/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SCLAlertView
import RealmSwift
class LeftMenuViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var anniversaryList = [Modal]()
    var anniversaryModal = Modal()
    var listSection = ["","Annyversaries"]
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let add = UIButton(frame: CGRect(x:15 , y: 650, width: 50, height: 50))
        add.setImage(UIImage(named: "add"), for:.normal)
        add.addTarget(self, action: #selector(addAnnivesary), for: .touchUpInside)
        anniversaryList = RealmService.shared.load(listOf: Modal.self, filter:"name CONTAINS 'Anniversary'")
        self.view.addSubview(add)
    }
    @objc func addAnnivesary() {
        var alert = SCLAlertView()
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        alert = SCLAlertView.init(appearance: appearance)
        let txt = alert.addTextField("Input Title")
        alert.addButton("OK",backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) {
            if(txt.text != ""){
                self.datePickerAleart(text: txt.text!)
            }
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("New Anniversary", subTitle: "")
    }
    func datePickerAleart(text : String){
       let datePicker = UIDatePicker()
       datePicker.datePickerMode = .date
       let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
       alert.view.addSubview(datePicker)
       
       
       let ok = UIAlertAction(title: "Done", style: .default) { (action) in
           let date = Date()
           let selectedDate =  datePicker.date
           let component = Calendar.current.dateComponents([.day], from:selectedDate, to: date)
           self.anniversaryModal.date = component.day!
           self.anniversaryModal.text = text
           self.anniversaryModal.name = "Anniversary"
           RealmService.shared.add(self.anniversaryModal, filter: "name CONTAINS 'Anniversary'")
           self.anniversaryList = RealmService.shared.load(listOf: Modal.self, filter: "name CONTAINS 'Anniversary'")
           self.tableView.reloadData()
           
       }
       
       let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
       alert.addAction(ok)
       alert.addAction(cancel)
       present(alert, animated: true, completion: nil)
       
   }
}
extension LeftMenuViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 3
        }
        else{
            return anniversaryList.count
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listSection[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return listSection.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            switch indexPath.row {
            case 0:
                let mainView = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                let bt2015 = sb.instantiateViewController(withIdentifier: "BT2015ViewController")
                if UserDefaults.standard.integer(forKey: "checkmark") == 0 {
                    slideMenuController()?.changeMainViewController(mainViewController: mainView, close: true)
                }
                else{
                    slideMenuController()?.changeMainViewController(mainViewController: bt2015, close: true)
                }
            case 1:
                let caculateDate = sb.instantiateViewController(withIdentifier: "CDTabBarViewController") as! CDTabBarViewController
                slideMenuController()?.changeMainViewController(mainViewController: caculateDate, close: true)
            case 2:
                let themesView = sb.instantiateViewController(withIdentifier: "ThemesViewController") as! ThemesViewController
                slideMenuController()?.changeMainViewController(mainViewController: themesView, close: true)
            default:
                print("Default")
            }
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0 ){
            if(indexPath.row == 0){
               let btCell = tableView.dequeueReusableCell(withIdentifier: "BeenTogetherCell")
               return btCell!
           }
        
           if(indexPath.row == 1){
               let cdCell = tableView.dequeueReusableCell(withIdentifier: "CaculateDateCell")
               return cdCell!
           }
           else{
                let themesCell = tableView.dequeueReusableCell(withIdentifier: "ThemesCell")
                return themesCell!
            }
        }
       
        else{
            let annyversariesCell = tableView.dequeueReusableCell(withIdentifier: "AnnyversariesCell")!
            anniversaryList = RealmService.shared.load(listOf: Modal.self, filter:"name CONTAINS 'Anniversary'")
            annyversariesCell.textLabel?.text = anniversaryList[indexPath.row].text
            annyversariesCell.detailTextLabel?.text = String(anniversaryList[indexPath.row].date)
            return annyversariesCell
        }
    }

    
}
