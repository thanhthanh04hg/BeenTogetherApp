//
//  SettingTableViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/30/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
//import RealmSwift
import SCLAlertView
import SwiftHSVColorPicker
class SettingTableViewController: UIViewController, UITableViewDelegate {
    weak var delegate : Delegate?
    let strFont =  UserDefaults.standard.string(forKey: "Font")!
    let functionList=[
        ["Person 1","Person 2","Change Tittle","Change Bottom Text"],
        ["Start Date","Start From 1", "Show year, month, day"],
        ["Use passcode lock"],
        ["Name Text Color","Day Text Color","Bar Color","Font"]
    ]
    
    let realmList = ["Person1" , "Person2","Title","Bottom"]
    let headSection = ["Name","Date Setting","App Settings","Display"]
    @IBOutlet weak var settingTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.register(UINib(nibName: "SwitchTableViewCell", bundle: nil), forCellReuseIdentifier: "SwitchTableViewCell")
        settingTable.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        settingTable.delegate = self
        settingTable.dataSource = self
    }
    @IBAction func changeMainView(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let mainView = sb.instantiateViewController(withIdentifier: "SlideMenuViewController") as! SlideMenuViewController
        present(mainView,animated: false)
    }

}
extension SettingTableViewController : UITableViewDataSource , UIFontPickerViewControllerDelegate  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return functionList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let str=headSection[section]
        return String(str)
    }
    func UIColorFromString(string: String) -> UIColor {
        let arr = string.components(separatedBy: " ")
        if(arr.count == 4){
            return UIColor(red: CGFloat((arr[0] as NSString).floatValue), green: CGFloat((arr[1] as NSString).floatValue), blue: CGFloat((arr[2] as NSString).floatValue), alpha: CGFloat((arr[3] as NSString).floatValue))
        }
        else {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell=tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! UITableViewCell
        if (indexPath.section == 0 ){
            detailCell.textLabel?.text=functionList[0][indexPath.row]
            var example = realmList[indexPath.item]
            detailCell.detailTextLabel?.text = RealmService.shared.get(Modal.self, filter: "name CONTAINS '"+example+"'").text
            return detailCell
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0 ) {
                detailCell.detailTextLabel?.text = toStringDate(date: UserDefaults.standard.object(forKey: "SelectedDate") as! Date)
                detailCell.textLabel?.text = functionList[1][indexPath.row]
                return detailCell
            }
            else{
                guard let switchCell=tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as? SwitchTableViewCell else{
                    return UITableViewCell()
                }
                switchCell.leftLabel.text = functionList[1][indexPath.row]
                if switchCell.leftLabel.text == "Start From 1"{
                    switchCell.switchButton.isOn = UserDefaults.standard.bool(forKey: "StartFrom1")
                }
                else{
                    switchCell.switchButton.isOn = UserDefaults.standard.bool(forKey: "ShowYearMonthDay")
                }
                return switchCell
            }
        }
        if(indexPath.section == 2){
            guard let switchCell=tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell") as? SwitchTableViewCell else{
                return UITableViewCell()
            }
            switchCell.leftLabel.text = "Use passcode lock"
            if switchCell.leftLabel.text == "Use passcode lock"{
                switchCell.switchButton.isOn = UserDefaults.standard.bool(forKey: "setPass")
                print(UserDefaults.standard.bool(forKey: "setPass"))
            }
            return switchCell
        }
        else{
            detailCell.textLabel?.text = functionList[3][indexPath.row]
            detailCell.detailTextLabel?.text = functionList[3][indexPath.row]
            if(indexPath.row == 0){
                let strLabelColor = UserDefaults.standard.string(forKey: "NameColor") 
                detailCell.detailTextLabel?.textColor = UIColorFromString(string : strLabelColor!)
            }
            if indexPath.row == 1{
                let strLabelColor = UserDefaults.standard.string(forKey: "LabelColor")
                detailCell.detailTextLabel?.textColor = UIColorFromString(string : strLabelColor!)
            }
            if(indexPath.row == 2){
                let strLabelColor = UserDefaults.standard.string(forKey: "BarColor")
                detailCell.detailTextLabel?.textColor = UIColorFromString(string : strLabelColor!)
            }
            if(indexPath.row == 3){
                if(strFont == nil){
                    detailCell.detailTextLabel?.text = "Helvetica Neue"
                }
                else{
                    detailCell.detailTextLabel?.text = UserDefaults.standard.string(forKey: "Font")
                }
                
            }
            return detailCell
        }
        
        
    }
    
    func showFontPicker() {
        let fontConfig = UIFontPickerViewController.Configuration()
        fontConfig.includeFaces = true
        let fontPicker = UIFontPickerViewController(configuration: fontConfig)
        fontPicker.delegate = self
        self.present(fontPicker, animated: true, completion: nil)
    }
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        guard let fontDescriptor = viewController.selectedFontDescriptor else { return }
        let font = UIFont(descriptor: fontDescriptor, size: 20)
        UserDefaults.standard.set(font.fontName, forKey: "Font")
        self.settingTable.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0 ){
            switch indexPath.row {
            case 0:
                var alert = SCLAlertView()
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                alert = SCLAlertView.init(appearance: appearance)
                let txt = alert.addTextField()
                txt.text = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person1'").text
                alert.addButton("OK",backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) {
                    let person1 = Modal()
                    person1.name = "Person1"
                    person1.text = txt.text!
                    RealmService.shared.add(person1, filter: "name CONTAINS 'Person1'")
                    tableView.reloadData()
                }
                alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
                    print("cancel")
                }
                alert.showEdit("Name", subTitle: "Person 1")
                
            case 1:
               var alert = SCLAlertView()
               let person2 = Modal()
               let appearance = SCLAlertView.SCLAppearance(
                   showCloseButton: false
               )
               
               alert = SCLAlertView.init(appearance: appearance)
               let txt = alert.addTextField()
               txt.text = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person2'").text
               alert.addButton("OK",backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) {
                   person2.name = "Person2"
                   person2.text = txt.text!
                   RealmService.shared.add(person2, filter: "name CONTAINS 'Person2'")
                   tableView.reloadData()
               }
               alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
                   print("cancel")
               }
               alert.showEdit("Name", subTitle: "Person 2")
           
            case 2:
                var alert = SCLAlertView()
                let upon = Modal()
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                alert = SCLAlertView.init(appearance: appearance)
                let txt = alert.addTextField()
                txt.text = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Title'").text
                alert.addButton("OK",backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) {
                    upon.name = "Title"
                    upon.text = txt.text!
                    RealmService.shared.add(upon, filter: "name CONTAINS 'Title'")
                    tableView.reloadData()
                }
                alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
                    print("cancel")
                }
                alert.showEdit("Change Title", subTitle: "")
                
                
            case 3:
                var alert = SCLAlertView()
                let bottom = Modal()
                let appearance = SCLAlertView.SCLAppearance(
                  showCloseButton: false
                )
                alert = SCLAlertView.init(appearance: appearance)
                let txt = alert.addTextField()
                txt.text = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Bottom'").text
                alert.addButton("OK",backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)) {
                  bottom.name = "Bottom"
                  bottom.text = txt.text!
                  RealmService.shared.add(bottom, filter: "name CONTAINS 'Bottom'")
                  tableView.reloadData()
                }
                alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
                  print("cancel")
                }
                alert.showEdit("Change Bottom Text", subTitle: "")
            default:
                print("NO")
            }
        }
        if(indexPath.section == 1){
            if(indexPath.row == 0) {
                datePickerAleart()
            }
    
        }
        if(indexPath.section == 2){
            
            if( UserDefaults.standard.bool(forKey: "setPass") == true ){
                let sb = UIStoryboard.init(name: "Main", bundle: nil);
                let passView = sb.instantiateViewController(withIdentifier: "SetPasscodeViewController") as! SetPasscodeViewController
                present(passView,animated: true)
                let button = UIButton(frame: CGRect(x: 350, y: 10, width:50, height: 50))
                button.setImage(UIImage(named: "close"), for: .normal)
                button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
                passView.view.addSubview(button)
            }

        }
        if(indexPath.section == 3){
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            switch indexPath.row {
            case 0:
                let selectColorView = sb.instantiateViewController(withIdentifier: "SelectColorViewController") as! SelectColorViewController
                self.delegate = selectColorView
                delegate?.passString("NameColor")
                self.present(selectColorView,animated: true)
                tableView.reloadData()
            case 1:
                let selectColorView = sb.instantiateViewController(withIdentifier: "SelectColorViewController") as! SelectColorViewController
                self.delegate = selectColorView
                delegate?.passString("LabelColor")
                self.present(selectColorView,animated: true)
                tableView.reloadData()
            case 2:
                let selectColorView = sb.instantiateViewController(withIdentifier: "SelectColorViewController") as! SelectColorViewController
                self.delegate = selectColorView
                delegate?.passString("BarColor")
                self.present(selectColorView,animated: true)
                tableView.reloadData()
            case 3:
                showFontPicker()
            default:
                print("default")
            }
        }
        
    }
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionList[section].count
    }
    func datePickerAleart(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Done", style: .default) { (action) in
            UserDefaults.standard.set(datePicker.date, forKey: "SelectedDate")
            self.settingTable.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
    }
    func toStringDate(date : Date)->(String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        return dateFormatter.string(from: date)
    }
}
