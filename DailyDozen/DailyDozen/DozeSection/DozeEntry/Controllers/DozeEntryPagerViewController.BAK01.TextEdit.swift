//
//  DozeEntryPagerViewController.swift
//  DailyDozen
//
//  Copyright © 2017 Nutritionfacts.org. All rights reserved.
//

import UIKit
import SimpleAnimation

// MARK: - Builder

class DozeEntryPagerBuilder {

    // MARK: - Methods
    /// Instantiates and returns the initial view controller for a storyboard.
    ///
    /// - Returns: The initial view controller in the storyboard.
    static func instantiateController() -> UIViewController {
        let storyboard = UIStoryboard(name: "DozeEntryPagerLayout", bundle: nil)
        guard
            let viewController = storyboard.instantiateInitialViewController()
            else { fatalError("Did not instantiate `DozeEntryPagerViewController`") }

        return viewController
    }
}

// MARK: - Controller
class DozeEntryPagerViewController: UIViewController {

    // MARK: - Properties
    
    /// Current display date
    private var currentDate = DateManager.currentDatetime() {
        didSet {
            if currentDate.isInCurrentDayWith(DateManager.currentDatetime()) {
                backButton.superview?.isHidden = true
                // :TBD:DELETE: setTitle(_ title: String?, for state: UIControl.State)
                // :TBD:DELETE: dateButton.setTitle(NSLocalizedString("dateButtonTitle.today", comment: "Date button 'Today' title"), for: .normal)
                dozeDateTextfield.text = NSLocalizedString("dateButtonTitle.today", comment: "Date button 'Today' title")
            } else {
                backButton.superview?.isHidden = false
                // :TBD:DELETE: dateButton.setTitle(dozeDatePicker.date.dateString(for: .long), for: .normal)
                dozeDateTextfield.text = dozeDatePicker.date.dateString(for: .long)
            }
        }
    }

    // MARK: - Outlets
    
    @IBOutlet weak var dozeDateTextfield: RoundedTextfield! {
        didSet {
            dozeDateTextfield.layer.borderWidth = 1
            // :TBD:DELETE: dateButton.layer.borderColor = dateButton.titleColor(for: .normal)?.cgColor
            dozeDateTextfield.layer.borderColor = dozeDateTextfield.textColor?.cgColor
            dozeDateTextfield.layer.cornerRadius = 5
        }
    }
    
    var dozeDatePicker: UIDatePicker! {
        didSet {
            dozeDatePicker.maximumDate = DateManager.currentDatetime() // today
            
            if #available(iOS 13.4, *) {
                // Compact style with overlay
                dozeDatePicker.preferredDatePickerStyle = .wheels
                // After mode and style are set apply UIView sizeToFit().
                dozeDatePicker.sizeToFit()
            }
        }
    }

    @IBOutlet private weak var backButton: UIButton!

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dozeDateTextfield.delegate = self
        dozeDateTextfield.allowsEditingTextAttributes = false
        
        dozeDatePicker = UIDatePicker()
        dozeDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            // Expressly use inline wheel (UIPickerView) style.
            dozeDatePicker.preferredDatePickerStyle = .wheels
            dozeDatePicker.sizeToFit()
        }
        dozeDatePicker.addTarget(self, action: #selector(DozeEntryPagerViewController.dateChanged(datePicker:)), for: .valueChanged)
        dozeDateTextfield.inputView = dozeDatePicker // assign initial value
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.greenColor
        navigationController?.navigationBar.tintColor = UIColor.white

        title = NSLocalizedString("navtab.doze", comment: "Daily Dozen (proper noun) navigation tab")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.greenColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if UserDefaults.standard.bool(forKey: SettingsKeys.hasSeenFirstLaunch) == false {
            UserDefaults.standard.set(true, forKey: SettingsKeys.hasSeenFirstLaunch)
            let viewController = FirstLaunchBuilder.instantiateController()
            navigationController?.pushViewController(viewController, animated: true)
        }

    }

    // MARK: - Methods
    /// Updates UI for the current date.
    ///
    /// - Parameter date: The current date.
    func updateDate(_ date: Date) {
        currentDate = date
        dozeDatePicker.setDate(date, animated: false)

        guard let viewController = children.first as? DozeEntryViewController else { return }
        viewController.view.fadeOut().fadeIn()
        viewController.setViewModel(date: currentDate)
    }

    // MARK: - Actions
    
    // // :!!!:
    //@IBAction private func dateButtonPressed(_ sender: UIButton) {
    //    dozeDatePicker.isHidden = false
    //    dozeDatePicker.maximumDate = DateManager.currentDatetime() // today
    //    dateButton.isHidden = true
    //}
    
     // :!!!:
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy" // :NYI:LOCALIZE:
        dozeDateTextfield.text =  dateFormatter.string(from: datePicker.date)
        
        //dateButton.isHidden = false
        //dozeDatePicker.isHidden = true
        //dozeDatePicker.maximumDate = DateManager.currentDatetime() // today
        //currentDate = dozeDatePicker.date
        //guard let viewController = children.first as? DozeEntryViewController else { return }
        //viewController.view.fadeOut().fadeIn()
        //viewController.setViewModel(date: dozeDatePicker.date)
    }

    @IBAction private func viewSwiped(_ sender: UISwipeGestureRecognizer) {
        let today = DateManager.currentDatetime()
        let interval = sender.direction == .left ? -1 : 1
        guard let swipedDate = dozeDatePicker.date.adding(.day, value: interval), 
              swipedDate <= today 
        else { return }

        dozeDatePicker.setDate(swipedDate, animated: false)
        dozeDatePicker.maximumDate = DateManager.currentDatetime() // today
        currentDate = dozeDatePicker.date

        guard let viewController = children.first as? DozeEntryViewController else { return }

        if sender.direction == .left {
            viewController.view.slideOut(x: -view.frame.width).slideIn(x: view.frame.width)
        } else {
            viewController.view.slideOut(x: view.frame.width).slideIn(x: -view.frame.width)
        }

        viewController.setViewModel(date: dozeDatePicker.date)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        updateDate(DateManager.currentDatetime())
    }
}

// MARK: - TextFieldDelegate

extension DozeEntryPagerViewController: UITextFieldDelegate {
    // :1:
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        LogService.shared.debug("textFieldShouldBeginEditing")
        
        // :===: should solve initial picker registration
        if textField.text == nil || textField.text!.isEmpty {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            if textField == dozeDateTextfield {
                dozeDateTextfield.text = dateFormatter.string(from: DateManager.currentDatetime())
            }
        }
        return true // return NO to disallow editing.
    }
    // :2:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //LogService.shared.debug("textFieldDidBeginEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        LogService.shared.debug("textFieldShouldReturn")
        view.endEditing(true)        
        //textField.resignFirstResponder()
        return true
    }
    
    // :3:
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        LogService.shared.debug("textFieldShouldEndEditing")
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
    
    // :4:
    func textFieldDidEndEditing(_ textField: UITextField) {
        //this is where you might add other code
        LogService.shared.debug("textFieldDidEndEditing")
    }
}
