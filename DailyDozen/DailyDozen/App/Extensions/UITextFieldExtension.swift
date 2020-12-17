//
//  UITextFieldExtension.swift
//  DailyDozen
//
//  Copyright © 2020 Nutritionfacts.org. All rights reserved.
//

import UIKit

extension UITextField {
    /// Assign DatePicker to Text Field `inputView`
    func datePicker<T>(
        target: T,
        cancelAction: Selector,
        doneAction: Selector,
        todayAction: Selector,
        datePickerMode: UIDatePicker.Mode = .date
    ) -> UIDatePicker {
        let screenWidth = UIScreen.main.bounds.width

        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 128) // 216
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 14, *) { // Added condition for iOS 14 and above
            // .compact => small non-selector view => old style wheels
            // .wheels  => old style wheels
            // .inline  => new style calendar quick select
            datePicker.preferredDatePickerStyle = .inline
            datePicker.sizeToFit()
        }
        self.inputView = datePicker
        // self.tintColor // match background color to "hide" caret
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        toolBar.isOpaque = false
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: target, action: cancelAction)
        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: target, action: todayAction)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: doneAction)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, flexSpace, todayButton, flexSpace, doneButton], animated: true)
        //self.inputAccessoryView = toolBar
        return datePicker
    }
    
}
