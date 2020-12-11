//
//  CollectionViewCell1.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import RealmSwift

class CollectionViewCell1: UICollectionViewCell {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var lblDays: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    var startFrom1 : Bool = true
    let currentDate : Date = Date()
    var selectedDate : Date = Date()
    var dateCount : Int = 0
//    var delegate : PassStrCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userDefault()
    }
    @IBAction func onChangedDay(_ sender: UIDatePicker) {
        selectedDate = sender.date
        UserDefaults.standard.set(selectedDate, forKey: "SelectedDate")
        let component = Calendar.current.dateComponents([.day], from: selectedDate, to: currentDate)
        dateCount=component.day!
        updateLbl()
//        delegate?.passStrCell(lblDays.text!)
        
    }
    @IBAction func onChangedStartDay(_ sender: UISegmentedControl) {
        startFrom1 = sender.selectedSegmentIndex == 0 ? true : false
        UserDefaults.standard.set(startFrom1, forKey: "StartFrom1")
        updateLbl()
    }
    
    func updateLbl () {
        if(startFrom1==true){
            if(dateCount+1<=1&&dateCount+1>=0){
                lblDays.text = "\(dateCount+1)"+"day"
            }
            else{
                lblDays.text = "\(dateCount+1)"+"days"
            }
        }
        else{
            if(dateCount<=1&&dateCount>=0){
                lblDays.text = "\(dateCount)"+"day"
            }
            else{
                lblDays.text = "\(dateCount)"+"days"
            }
        }
        UserDefaults.standard.set(dateCount, forKey: "dateCount")
    }
    func userDefault(){
//        UserDefaults.standard.set(selectedDate, forKey: "SelectedDate")
        UserDefaults.standard.set(startFrom1, forKey: "StartFrom1")
//        print(UserDefaults.standard.object(forKey: "SelectedDate"))
        UserDefaults.standard.set(false, forKey: "ShowYearMonthDay")
    }
}

