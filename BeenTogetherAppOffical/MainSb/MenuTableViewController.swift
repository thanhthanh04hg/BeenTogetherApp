//
//  MenuTableViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/18/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SlideMenuDovi
import RealmSwift
import SCLAlertView


class MenuTableViewController: UIViewController {
    var anniversaryList = [Modal]()
    var anniversaryModal = Modal()
    @IBOutlet weak var menuTable: UITableView!
    //    var didTapMenuType: ((MenuType) -> Void)?
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTable.dataSource = self
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
    
    @IBAction func changeMainView(_ sender: Any) {
        let mainView = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        slideMenuController()?.changeMainViewController(mainViewController: mainView, close: true)
    }
    @IBAction func changeCaculateDateView(_ sender: Any) {
        let caculateDate = sb.instantiateViewController(withIdentifier: "CDTabBarViewController") as! CDTabBarViewController
        slideMenuController()?.changeMainViewController(mainViewController: caculateDate, close: true)
    }
}
extension MenuTableViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anniversaryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! UITableViewCell
//        RealmService.shared.load(listOf: Modal.self, filter: "Anniversary")
        anniversaryList = RealmService.shared.load(listOf: Modal.self, filter:"name CONTAINS 'Anniversary'")
        cell.textLabel?.text = anniversaryList[indexPath.row].text
        cell.detailTextLabel?.text = String(anniversaryList[indexPath.row].date)
       return cell
   }
   func numberOfSections(in tableView: UITableView) -> Int {
       return 1
   }
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Anniversaries"
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
            self.menuTable.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }

}

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell=tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! UITableViewCell
//        switch cell[indexPath] {
//        case 0:
//            let mainView = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//            slideMenuController()?.changeMainViewController(mainViewController: mainView, close: true)
//        case 1:
//            let caculateDate = sb.instantiateViewController(withIdentifier: "CaculateDateViewController") as! CaculateDateViewController
//            slideMenuController()?.changeMainViewController(mainViewController: caculateDate, close: true)
//        default:
//            print ("Stop")
//        }
//        print(cell.)

//    }
    
