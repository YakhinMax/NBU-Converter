//
//  DataSourceExtension.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

extension ExchangeViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyData.count
    }
}
