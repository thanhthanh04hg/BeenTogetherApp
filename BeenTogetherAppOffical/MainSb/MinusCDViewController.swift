//
//  MinusCDViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/7/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class MinusCDViewController: UIViewController {

    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var intialBtn: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    var intialDate = UserDefaults.standard.object(forKey: "SelectedDate") as! Date
    var secondDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        intialBtn.setTitle(toStringDate(date: intialDate), for: .normal)
        secondBtn.setTitle(toStringDate(date: Date()), for: .normal)
        let component = Calendar.current.dateComponents([.day], from: intialDate, to: secondDate)
        label.text = String(component.day!) + "days"
    }
    
    
    @IBAction func onDisplayIntialDate(_ sender: Any) {
        datePickerAleart(sender: intialBtn)
    }
    
    @IBAction func onDisplaySecondDate(_ sender: Any) {
        datePickerAleart(sender: secondBtn)
        
    }
    @IBAction func onDisplayCaculateDate(_ sender: UISegmentedControl) {
        let component = Calendar.current.dateComponents([.day], from: intialDate, to: secondDate)
        let com = Calendar.current.dateComponents([.year,.month,.day], from: intialDate, to: secondDate)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text="\(component.day!)" + "days"
        case 1:
            var strYMD = "\(com.day!)"+"days"
            let strYear = "\(com.year!)"+"years"
            let strMonth = "\(com.month!)" + "months"
            if(com.month != 0){
                strYMD = strMonth + strYMD
            }
            if(com.year != 0 ){
                strYMD = strYear + strYMD
            }
            label.text = strYMD
        default:
            print("deafault")
        }
    }

    func toStringDate(date : Date)->(String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        return dateFormatter.string(from: date)
    }
    func datePickerAleart(sender:UIButton ){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Done", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd,yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            sender.setTitle(dateString, for: .normal)
            if(sender == self.intialBtn){
                let component = Calendar.current.dateComponents([.day], from: datePicker.date, to: self.secondDate)
                self.label.text = String(component.day!) + "days"
            }
            else{
                let component = Calendar.current.dateComponents([.day], from: self.intialDate, to: datePicker.date)
                self.label.text = String(component.day!) + "days"
            }
            
            print(dateString)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}
