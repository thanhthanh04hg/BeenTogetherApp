//
//  MainViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var tdButton: UIButton!
    @IBOutlet var btButton: UIButton!
    @IBOutlet var trailing: NSLayoutConstraint!
    @IBOutlet var leading: NSLayoutConstraint!
    @IBOutlet var mainDay: UILabel!
    var timer = Timer()
    var titleDelegate : TitleDelegate?
    var finalLbl="Been Together"
    var finalBottom = "Today"
//    func passData(_ label: String) {
//        finalLbl=label
//    }
    var count : Int = 0
    var menuOut = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        mainDay.text=finalLbl
//        print (UserDefaults.standard.integer(forKey: "dateCount"))
/* setting time */
//        updateTime()
       mainDay.text="\(count)" + "days"
        print ("onMain")
/* Title */
//       finalLbl = UserDefaults.standard.string(forKey: "Title")!
//       btButton.setTitle(self.finalLbl, for: .normal)
/* Bottom */
//        finalBottom = UserDefaults.standard.string(forKey: "Bottom")!
//        tdButton.setTitle(self.finalBottom, for: .normal)
/* progress */
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MainViewController.update), userInfo: nil, repeats: true)
    }
    @IBAction func manuTapped(_ sender: Any) {
        remainMenu()
    }
 
    @IBAction func BTView(_ sender: Any) {
        remainMenu()
    }
    
    @IBAction func changeCDView(_ sender: Any) {
        let sb=UIStoryboard.init(name: "MainSb", bundle: nil)
             let cdView=sb.instantiateViewController(withIdentifier: "CaculateDateViewController") as! CaculateDateViewController
             self.navigationController?.pushViewController(cdView, animated: true)
    }
    
    @IBAction func changeTitleUpon(_ sender: Any) {
        let titleSb = UIStoryboard.init(name: "MainSb", bundle: nil)
        let titleVC = titleSb.instantiateViewController(withIdentifier: "TitleViewController") as! TitleViewController
        self.titleDelegate = titleVC
        titleDelegate?.passLabel("Change Title",finalLbl)
        UserDefaults.standard.set(true, forKey: "isTitle")
        titleVC.onDisplayText={
            UserDefaults.standard.set($0, forKey: "Title")
            self.finalLbl = UserDefaults.standard.string(forKey: "Title")!
            self.btButton.setTitle(self.finalLbl, for: .normal)
        }
//        finalLbl = UserDefaults.standard.string(forKey: "Title")!
//        print (finalLbl)
//        print (UserDefaults.standard.string(forKey: "Title")!)
        
        self.addChild(titleVC)
        titleVC.view.frame = self.view.frame
        self.view.addSubview(titleVC.view)
        titleVC.didMove(toParent: self)
        
    }
    @IBAction func changeBottomText(_ sender: Any) {
       let titleSb = UIStoryboard.init(name: "MainSb", bundle: nil)
       let titleVC = titleSb.instantiateViewController(withIdentifier: "TitleViewController") as! TitleViewController
       self.titleDelegate = titleVC
       titleDelegate?.passLabel("Change Bottom Text",finalBottom)
        UserDefaults.standard.set(false, forKey: "isTitle")
       titleVC.onDisplayText={
           UserDefaults.standard.set($0, forKey: "Bottom")
           self.finalBottom = UserDefaults.standard.string(forKey: "Bottom")!
           self.tdButton.setTitle(self.finalBottom, for: .normal)
       }
        
       self.addChild(titleVC)
       titleVC.view.frame = self.view.frame
       self.view.addSubview(titleVC.view)
       titleVC.didMove(toParent: self)
        
    }
    @objc func update(){
        progressView.progress = Float(count)/100
//        print (Float(count)/100)
    }

    /* func */
    
    func remainMenu(){
        if(menuOut==false){
            leading.constant = 150;
            trailing.constant = -150;
            menuOut=true;
        }else{
            leading.constant=0;
            trailing.constant=0;
            menuOut=false;
        }
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: {
            (finished) in
            print("Animation is completed")
            })
        
    }
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Add new tag", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
                self.btButton.setTitle(text, for: .normal)
                print(text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func updateTime(){
        count  = UserDefaults.standard.integer(forKey: "dateCount")
        let currentDate = UserDefaults.standard.object(forKey: "currentDate") as! Date
        let today=Date()
        let order = Calendar.current.compare(currentDate, to: today, toGranularity: .day)
        switch order {
        case .orderedDescending:
            print("DESCENDING")
            UserDefaults.standard.set(count+1, forKey: "dateCount")
            UserDefaults.standard.set(today, forKey: "currentDate")
        case .orderedAscending:
            print("ASCENDING")
            UserDefaults.standard.set(count+1, forKey: "dateCount")
            UserDefaults.standard.set(today, forKey: "currentDate")
        case .orderedSame:
            print("SAME")
        }
    }
}
//protocol Delegate : class {
//    func passData(_ label:String)
//}



