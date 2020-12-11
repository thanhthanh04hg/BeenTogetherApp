//
//  MainViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SlideMenuDovi
import SCLAlertView
import RealmSwift
import SwiftHSVColorPicker
class MainViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var person2Btn: UIButton!
    @IBOutlet weak var person1Btn: UIButton!
    @IBOutlet var tdButton: UIButton!
    @IBOutlet var btButton: UIButton!
    @IBOutlet var mainDay: UILabel!
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
        btButton.setTitleColor(UIColorFromString(string: strLabelColor), for: .normal)
        tdButton.setTitleColor(UIColorFromString(string: strLabelColor), for: .normal)
        
        let strNameColor = UserDefaults.standard.string(forKey: "NameColor")!
        person1Btn.setTitleColor(UIColorFromString(string: strNameColor), for: .normal)
        person2Btn.setTitleColor(UIColorFromString(string: strNameColor), for: .normal)
        
        let strBarColor = UserDefaults.standard.string(forKey: "BarColor")!
        progressView.tintColor = UIColorFromString(string: strBarColor)
        /* Font */
        guard let font = UserDefaults.standard.string(forKey: "Font") else{
            return
        }
        mainDay.font = UIFont(name: font, size: 30)
        btButton.titleLabel?.font = UIFont(name: font, size: 25)
        tdButton.titleLabel?.font = UIFont(name: font, size: 25)
        person1Btn.titleLabel?.font = UIFont(name: font, size: 17)
        person2Btn.titleLabel?.font = UIFont(name: font, size: 17)
        
        
//        if(UserDefaults.standard.integer(forKey: "checkmark") == 0){
//            let sb = UIStoryboard.init(name: "Main", bundle: nil)
//            let bt2018View = sb.instantiateViewController(withIdentifier: "BT2018ViewController") as! BT2018ViewController
//            self.addChild(bt2018View)
//            bt2018View.view.frame = self.view.frame
//            self.view.addSubview(bt2018View.view)
//            bt2018View.didMove(toParent: self)
//        }
        
/* Title */
        
        intialTitle =  RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Title'")
        btButton.setTitle(intialTitle.text, for: .normal)
/* Bottom */
        
        intialBottom = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Bottom'")
        tdButton.setTitle(intialBottom.text, for: .normal)
/* Person1's name*/
        intialPerson1 = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person1'")
        person1Btn.setTitle(intialPerson1.text, for: .normal)
/* Person2's name*/
        
        intialPerson2 = RealmService.shared.get(Modal.self, filter: "name CONTAINS 'Person2'")
        person2Btn.setTitle(intialPerson2.text, for: .normal)
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
    @IBAction func onDisplayMenu(_ sender: Any) {
        slideMenuController()?.openSlideMenuLeft()
    }
    
    @IBAction func onDisplaySettingMenu(_ sender: Any) {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let settingView = sb.instantiateViewController(withIdentifier: "SettingTableViewController") as! SettingTableViewController
        present(settingView, animated: true, completion: nil)
        
    }
    @IBAction func changeTitleUpon(_ sender: Any) {
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
            self.btButton.setTitle(upon.text, for: .normal)
        }
        alert.addButton("Cancel", backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)){
            print("cancel")
        }
        alert.showEdit("Change Title", subTitle: "")
        

    }
    @IBAction func changeBottomText(_ sender: Any) {
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
           self.tdButton.setTitle(bottom.text, for: .normal)
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
    @objc func update(){
        progressView.progress = Float(count)/100
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


    
//    func transitionToNew(_ menuType: MenuType) {
//         topView?.removeFromSuperview()
//         switch menuType {
//         case .heart:
//           print ("heart")
//         case .date:
//             let sb = UIStoryboard.init(name: "Main", bundle: nil)
//             let cdView = sb.instantiateViewController(withIdentifier: "CaculateDateViewController") as! CaculateDateViewController
//             self.navigationController?.pushViewController(cdView, animated: true)
//             self.present(cdView, animated: true)
//         default:
//             break
//         }
//     }

    




//    func createNavigaionBar(){
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width , height: 40))
//        navBar.contentMode = .scaleAspectFit
//        view.addSubview(navBar)
//        let navItem = UINavigationItem(title: "")
//        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: nil, action: #selector(menu))
//        let settingButton = UIBarButtonItem(image: UIImage(named: "setting"), style: .done, target: nil, action: #selector(setting))
//        let pictureButton = UIBarButtonItem(image: UIImage(named: "picture"), style: .done, target: nil, action: #selector(picture))
//        navItem.leftBarButtonItem = menuButton
//        navItem.rightBarButtonItems = [ settingButton , pictureButton]
//        navBar.setItems([navItem], animated: false)
//
//    }
//     @objc func menu() {
//            guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController else { return }
//            menuViewController.didTapMenuType = { menuType in
//                self.transitionToNew(menuType)
//            }
//            menuViewController.modalPresentationStyle = .overCurrentContext
//            menuViewController.transitioningDelegate = self
//    //        UIView.animate(withDuration: 1) {
//    //            print("Hello")
//    //        }
//            present(menuViewController, animated: true)
//
//        }


//protocol Delegate : class {
//    func passData(_ label:String)
//}

//@IBAction func changeTitleUpon(_ sender: Any) {
//        let titleSb = UIStoryboard.init(name: "Main", bundle: nil)
//        let titleVC = titleSb.instantiateViewController(withIdentifier: "TitleViewController") as! TitleViewController
//        self.titleDelegate = titleVC
//        titleDelegate?.passLabel("Change Title",finalLbl)
//        UserDefaults.standard.set(true, forKey: "isTitle")
//        titleVC.onDisplayText={
//            UserDefaults.standard.set($0, forKey: "Title")
//            self.finalLbl = UserDefaults.standard.string(forKey: "Title")!
//            RealmService.shared.load(listOf: Box.self, filter: "Thanh")
//            self.btButton.setTitle(self.finalLbl, for: .normal)
//        }
//        self.navigationController?.isNavigationBarHidden = true
//        print (finalLbl)
//        finalLbl = UserDefaults.standard.string(forKey: "Title")!
//        print (UserDefaults.standard.string(forKey: "Title")!)
        
//        self.addChild(titleVC)
//        titleVC.view.frame = self.view.frame
//        self.view.addSubview(titleVC.view)
//        titleVC.didMove(toParent: self)
//}
//    @IBAction func onDisplayMenu(_ sender: Any) {
//        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController else { return }
//                menuViewController.didTapMenuType = { menuType in
//                    self.transitionToNew(menuType)
//                }
//
//        menuViewController.modalPresentationStyle = .overCurrentContext
//        menuViewController.transitioningDelegate = self
//        self.present(menuViewController, animated: true)
  
//    }
    

    /* func */
//    private func setupNavigationBar (){
//        let titleImageView = UIImageView(image:)
//        navigationItem.titleView = titleImageView
//    }
