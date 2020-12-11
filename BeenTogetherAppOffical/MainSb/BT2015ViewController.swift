//
//  BT2018ViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/15/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SlideMenuDovi
import SCLAlertView
import RealmSwift
import SwiftHSVColorPicker


class BT2015ViewController: UIViewController {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var person1Btn: UIButton!
    @IBOutlet weak var person2Btn: UIButton!
    @IBOutlet weak var mainDay: UILabel!
    @IBOutlet weak var tdBtn: UIButton!
    @IBOutlet weak var btBtn: UIButton!
     var topView: UIView?
     var timer = Timer()
     var titleDelegate : TitleDelegate?
     var intialTitle = Modal()
     var intialBottom = Modal()
     var intialPerson1 = Modal()
     var intialPerson2 = Modal()
    
     var count : Int = 0
     var menuOut = false
    override func viewDidLoad() {
        super.viewDidLoad()
/* setting time */
        updateTime()
        UserDefaults.standard.set(count, forKey: "count")
/*progress bar */
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MainViewController.update), userInfo: nil, repeats: true)
        if(UserDefaults.standard.bool(forKey: "isDateSet") == false){
            intialRealm()
        }
        UserDefaults.standard.set(true, forKey: "isDateSet")
        /* Color */
        let strLabelColor = UserDefaults.standard.string(forKey: "LabelColor")!
        mainDay.textColor = UIColorFromString(string: strLabelColor)
        btBtn.setTitleColor(UIColorFromString(string: strLabelColor), for: .normal)
        tdBtn.setTitleColor(UIColorFromString(string: strLabelColor), for: .normal)
        
        let strNameColor = UserDefaults.standard.string(forKey: "NameColor")!
        person1Btn.setTitleColor(UIColorFromString(string: strNameColor), for: .normal)
        person2Btn.setTitleColor(UIColorFromString(string: strNameColor), for: .normal)
        
        let strBarColor = UserDefaults.standard.string(forKey: "BarColor")!
        progressBar.tintColor = UIColorFromString(string: strBarColor)
        /* Font */
        guard let font = UserDefaults.standard.string(forKey: "Font") else{
            return
        }
        mainDay.font = UIFont(name: font, size: 30)
        btBtn.titleLabel?.font = UIFont(name: font, size: 25)
        tdBtn.titleLabel?.font = UIFont(name: font, size: 25)
        person1Btn.titleLabel?.font = UIFont(name: font, size: 17)
        person2Btn.titleLabel?.font = UIFont(name: font, size: 17)
        
/* Title */
        
        intialTitle =  RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Title'")
        btBtn.setTitle(intialTitle.text, for: .normal)
/* Bottom */
        
        intialBottom = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Bottom'")
        tdBtn.setTitle(intialBottom.text, for: .normal)
/* Person1's name*/
        intialPerson1 = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person1'")
        person1Btn.setTitle(intialPerson1.text, for: .normal)
/* Person2's name*/
        
        intialPerson2 = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person2'")
        person2Btn.setTitle(intialPerson2.text, for: .normal)
    }
    @IBAction func changeUpperTitle(_ sender: Any) {
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
            self.btBtn.setTitle(upon.text, for: .normal)
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("Change Title", subTitle: "")
        

    }
    
    @IBAction func changeBottomTitle(_ sender: Any) {
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
            self.tdBtn.setTitle(bottom.text, for: .normal)
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("Change Bottom Text", subTitle: "")
    }
    
    @IBAction func changePerson1Name(_ sender: Any) {
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
            self.person1Btn.setTitle(person1.text, for: .normal)
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("Name", subTitle: "Person 1")
        
    }
    
    @IBAction func changePerson2Name(_ sender: Any) {
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
            self.person2Btn.setTitle(person2.text, for: .normal)
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("Name", subTitle: "Person 2")
    }
    
    
    @IBAction func onDisplayMenu(_ sender: Any) {
        slideMenuController()?.openSlideMenuLeft()
    }
    
    @IBAction func onDisplaySetting(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let settingView = sb.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        present(settingView, animated: true, completion: nil)
    }
    
    func intialRealm(){
        
        intialTitle.text = "Been Together"
        intialTitle.name = "Title"
        RealmService.shared.add(intialTitle, filter: "name CONTAINS 'Title'")
    
    
        intialBottom.text = "Today"
        intialBottom.name = "Bottom"
        RealmService.shared.add(intialBottom, filter: "name CONTAINS 'Bottom'")
    
        intialPerson1.text = "Person 1"
        intialPerson1.name = "Person1"
        RealmService.shared.add(intialPerson1, filter: "name CONTAINS 'Person1'")
            
        intialPerson2.text = "Person 2"
        intialPerson2.name = "Person2"
        RealmService.shared.add(intialPerson2, filter: "name CONTAINS 'Person2'")

    }
    func firstRealm(){
        
        intialTitle.text = "Been Together"
        intialTitle.name = "Title"
        RealmService.shared.add(intialTitle, filter: "name CONTAINS 'Title'")
    
    
        intialBottom.text = "Today"
        intialBottom.name = "Bottom"
        RealmService.shared.add(intialBottom, filter: "name CONTAINS 'Bottom'")
    
        intialPerson1.text = "Person 1"
        intialPerson1.name = "Person1"
        RealmService.shared.add(intialPerson1, filter: "name CONTAINS 'Person1'")
            
        intialPerson2.text = "Person 2"
        intialPerson2.name = "Person2"
        RealmService.shared.add(intialPerson2, filter: "name CONTAINS 'Person2'")

    }
    @objc func update(){
        progressBar.progress = Float(count)/100
    }
    func updateTime(){
        var startDate = UserDefaults.standard.object(forKey:"SelectedDate") as! Date
        let currentDate = Date()
        let component = Calendar.current.dateComponents([.day], from: startDate , to: currentDate)
        count  = component.day!
//        if(UserDefaults.standard.bool(forKey: "ShowYearMonthDay") == true){
        var com = Calendar.current.dateComponents([.month,.year,.day], from: startDate, to: currentDate)
        let checkDay = UserDefaults.standard.bool(forKey: "StartFrom1")
        if(checkDay == true){
            count+=1
            com.day! += 1
        }
        if(UserDefaults.standard.bool(forKey: "ShowYearMonthDay") == true){
            var strYMD = "\(com.day!)"+"days"
            let strYear = "\(com.year!)"+"years"
            let strMonth = "\(com.month!)" + "months"
            if(com.month != 0){
                strYMD = strMonth + strYMD
            }
            if(com.year != 0 ){
                strYMD = strYear + strYMD
            }
            mainDay.text = strYMD
            
        }
        if(UserDefaults.standard.bool(forKey: "ShowYearMonthDay") == false){
            mainDay.text="\(count)" + "days"
        }
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

}
