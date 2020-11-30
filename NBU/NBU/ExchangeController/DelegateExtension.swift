//
//  DelegateExtension.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

extension ExchangeViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyData[row].txt
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let exchangeRate = countRate()
        
        // This better be done with 2 separate delegates, but this way is shorter
        if pickerView == picker1 {
            currency1.text = currencyData[row].cc
            guard let text = textedit1.text, Double(text) != nil else { return }
            textedit2.text = String(format: "%.1f", Double(text)! * exchangeRate)
        }
        if pickerView == picker2 {
            currency2.text = currencyData[row].cc
            guard let text = textedit2.text, Double(text) != nil else { return }
            textedit1.text = String(format: "%.1f", Double(text)! / exchangeRate)
        }
    }
}
