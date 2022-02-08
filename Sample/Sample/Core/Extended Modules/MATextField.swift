//
//  MATextField.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit


@IBDesignable
class MATextField: UITextField {
    
    //MARK: - Variables
    var padding: UIEdgeInsets?
    var pickerView: UIPickerView?
    var pickerData: [String]?
    var datePicker: UIDatePicker?
    var isTime = false
    
    
    //MARK: - Nib Methods
    override func awakeFromNib() {
        padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 60)
        delegate = self
        backgroundColor = UIColor(named: "TextFieldBG")
        placeHolderColor = UIColor.lightGray
    }
    
    
    //MARK: - IBInspectable
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor!])
        }
    }
    
    
    //MARK: - FirstResponder Methods
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Padding Setting
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets())
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets())
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding ?? UIEdgeInsets())
    }
    
    
    //MARK: - Picker Method
    func setTextFieldAsPicker(_ data: [String]) {
        pickerView = UIPickerView()
        inputView = pickerView
        pickerData = data
        pickerView?.dataSource = self
        pickerView?.delegate = self
    }
    
    func setTextFieldasDatePicker() {
        isTime = false
        datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        inputView = datePicker
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    
    @objc func handleDatePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        text = dateFormatter.string(from: datePicker?.date ?? Date())
    }
    
    func setTextFieldasTimePicker() {
        isTime = true
        datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        inputView = datePicker
        datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(handleTimePicker), for: .valueChanged)
    }
    
    @objc func handleTimePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        text = dateFormatter.string(from: datePicker?.date ?? Date())
    }
}


//MARK: - UITextFieldDelegate Methods
extension MATextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if pickerView != nil {
            text = pickerData?[0]
        }
        
        if datePicker != nil {
            if isTime {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                if text == "" {
                    text = dateFormatter.string(from: datePicker?.date ?? Date())
                } else {
                    datePicker?.setDate(dateFormatter.date(from: text!) ?? Date(), animated: true)
                }
                
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                if text == "" {
                    text = dateFormatter.string(from: datePicker?.date ?? Date())
                } else {
                    datePicker?.setDate(dateFormatter.date(from: text!) ?? Date(), animated: true)
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.endEditing(true)
    }
}


//MARK: - UIPickerViewDataSource Methods
extension MATextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData?.count ?? 0
    }
    
}


//MARK: - UIPickerViewDataSource Methods
extension MATextField: UIPickerViewDelegate {
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData![row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = pickerData?[row]
    }
}
