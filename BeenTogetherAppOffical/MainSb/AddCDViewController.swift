//
//  AddCDViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/7/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class AddCDViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var addText: UITextField!
    @IBOutlet weak var button: UIButton!
    var selectedDate =  UserDefaults.standard.object(forKey: "SelectedDate") as! Date
    var finalCount : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle(toStringDate(date: selectedDate), for: .normal)
//        addText.text = String(finalCount!)
        var dateComponent = DateComponents()
        addText.text = String(UserDefaults.standard.integer(forKey: "count"))
        dateComponent.day = Int(addText.text!)
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate )
        label.text = toStringDate(date: futureDate!)
        
    }
    
    @IBAction func onDisplayCaculateDate(_ sender: Any) {
        var dateComponent = DateComponents()
        dateComponent.day = Int(addText.text!)
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate )
        label.text = toStringDate(date: futureDate!)
    }
    @IBAction func changeStartFrom(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            var dateComponent = DateComponents()
            dateComponent.day = Int(addText.text!)
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate )
            label.text = toStringDate(date: futureDate!)
        case 1:
            var dateComponent = DateComponents()
            if let a = Int(addText.text!){
                dateComponent.day = a + 1
            } else {
                dateComponent.day = 1
            }
            
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate )
            label.text = toStringDate(date: futureDate!)
        default:
            print ("default")
        }
    }
    
    @IBAction func changeStartdate(_ sender: Any) {
        datePickerAleart()
    }
    func toStringDate(date : Date)->(String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd,yyyy"
        return dateFormatter.string(from: date)
    }
    func datePickerAleart(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Done", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd,yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            self.button.setTitle(dateString, for: .normal)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

        
    }
}


