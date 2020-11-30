//
//  ExchangeViewController.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController{

    var currencyData : [CurrencyData] = []
    var rate : Double = 1.0
    
    @IBOutlet weak var currency1: UILabel!
    @IBOutlet weak var currency2: UILabel!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var textedit1: UITextField!
    @IBOutlet weak var textedit2: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currencyData.append(CurrencyData(r030: -1, txt: "Гривня", rate: 1, cc: "UAH", exchangedate: ""))
        reloadPickers()
        requestData(urlString: UserDefaults.standard.string(forKey: "jsonUrl")!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func requestData(urlString: String) {
        // This can be done in a separate model class, but that would take a bit more time to implement correctly (According to MVC)
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            print("Connected to " + urlString)
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                guard data != nil else { return }
                do {
                    let res = try JSONDecoder().decode([CurrencyData].self, from: data!)
                    self.currencyData.removeAll()
                    self.currencyData.append(CurrencyData(r030: -1, txt: "Гривня", rate: 1, cc: "UAH", exchangedate: ""))
                    self.currencyData.append(contentsOf: res)
                    DispatchQueue.main.async {
                        self.reloadPickers()
                    }
                }
                catch let err {
                    print(err)
                }
            }.resume()
        }
    }
    
    func reloadPickers() {
        picker1.reloadAllComponents()
        picker2.reloadAllComponents()
        pickerView(picker1, didSelectRow: 0, inComponent: 0)
        pickerView(picker2, didSelectRow: 0, inComponent: 0)
    }
    
    func countRate() -> Double {
        let cur1 = currencyData[picker1.selectedRow(inComponent: 0)]
        let cur2 = currencyData[picker2.selectedRow(inComponent: 0)]
        
        return cur1.rate / cur2.rate
    }
    
    @IBAction func numberChanged(_ sender: UITextField) {
        guard let text = sender.text, Double(text) != nil else { return }
        
        let exchangeRate = countRate()
        
        if sender == textedit1 {
            textedit2.text = String(format: "%.1f", Double(text)! * exchangeRate)
        }
        else if sender == textedit2 {
            textedit1.text = String(format: "%.1f", Double(text)! / exchangeRate)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            guard self.bottomConstraint != nil else {
                return
            }
            self.bottomConstraint.constant = keyboardHeight
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5, animations: {
            guard self.bottomConstraint != nil else {
                return
            }
            self.bottomConstraint.constant = 0
        })
    }
}
