//
//  CurrencyTableViewCell.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCurrency(curr: String?, val: Double?) {
        currency.text = curr
        value.text = String(format: "%.1f", val!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
