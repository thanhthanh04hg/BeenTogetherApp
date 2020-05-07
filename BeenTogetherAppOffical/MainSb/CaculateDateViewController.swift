//
//  CaculateDateViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/1/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class CaculateDateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func selectDatePicker(_ sender: Any) {
        datePickerAleart()
    }
    func datePickerAleart(){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Done", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let dateString = dateFormatter.string(from: datePicker.date)
            print(dateString)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
            
        
    }

}
