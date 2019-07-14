//
//  ViewController.swift
//  Notes
//
//  Created by Alex Prokudin on 03/07/2019.
//  Copyright © 2019 Alex Prokudin. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var noteHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var datePickerSwitch: UISwitch!
    @IBOutlet weak var colorPanelCollectionView: ColorPanelCollectionView!
    
    private let datePickerDefaultLength: CGFloat = 216
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.datePickerHeight.constant = 0;
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI()
    }
    
    @IBAction func dateSwitchChanged(_ sender: UISwitch) {
        DDLogInfo("Date switch changed: \(sender.isOn)")
        
        // show view right away, if needed
        if (sender.isOn) {
            self.datePickerView.isHidden = false
        }
        animateDatePicker(shouldCollapse: !sender.isOn)
        
        // close keyboard, as user has ended his work with text
        dismissKeyboard()
    }
    
    private func animateDatePicker(shouldCollapse: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.datePickerHeight.constant = shouldCollapse ? 0 : self.datePickerDefaultLength
            self.view.layoutIfNeeded()
        }, completion: { finished in
            // will hide it after animation end
            self.updateUI()
        })
    }
    
    private func updateUI() {
        self.noteHeightConstraint.constant = self.view.bounds.height / 4
        self.datePickerView.isHidden = !self.datePickerSwitch.isOn
        
        // need to invalidate collection view to layout it again after rotation
        self.colorPanelCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        scrollView.contentInset.bottom = 0
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
}
