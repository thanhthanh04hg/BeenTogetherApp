//
//  CollectionViewCell1.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class CollectionViewCell1: UICollectionViewCell {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var lblDays: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    var startFrom1 : Bool = true
    var currentDate : Date = Date()
    var selectedDate : Date = Date()
    var dateCount : Int = 0
//    var delegate : PassStrCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func onChangedDay(_ sender: UIDatePicker) {
        selectedDate = sender.date
        let component = Calendar.current.dateComponents([.day], from: selectedDate, to: currentDate)
        dateCount=component.day!
        updateLbl()
//        delegate?.passStrCell(lblDays.text!)
        
    }
    @IBAction func onChangedStartDay(_ sender: UISegmentedControl) {
        startFrom1 = sender.selectedSegmentIndex == 0 ? true : false
        updateLbl()
//            switch index {
//            case 0:
//                let date1=Date()
//                let date2=datePicker.date
//                let component=Calendar.current.dateComponents([.day], from: date2, to: date1)
//                var caculate:Int?
//                if(component.day!==0){
//                    caculate=component.day!+1
//                }
//                if(component.day!<0){
//                    caculate=component.day!
//                }
//                else{
//                    caculate=component.day!+1
//                }
//                lblDays.text="\(caculate!)"+"days"
//            case 1:
//                let date1=Date()
//                let date2=datePicker.date
//                let component=Calendar.current.dateComponents([.day], from: date2, to: date1)
//                lblDays.text="\(component.day!)"+"days"
//            default:
//                print ("No select")
//            }
    }
    
    func updateLbl () {
        if(startFrom1==true){
            dateCount+=1
        }
        if(dateCount<=1){
            lblDays.text = "\(dateCount)"+"day"
        }
        else {
            lblDays.text="\(dateCount)" + "days"
        }
        UserDefaults.standard.set(dateCount, forKey: "dateCount")
        UserDefaults.standard.set(currentDate, forKey: "currentDate")
    }
}

