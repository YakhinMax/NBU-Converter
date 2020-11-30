//
//  CurrencyTableViewController.swift
//  NBU
//
//  Created by Maxim Yakhin on 30.11.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class CurrencyTableViewController: UITableViewController {
    
    var currencyData : [CurrencyData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getData(urlString: UserDefaults.standard.string(forKey: "jsonUrl")!)
    }
    
    func getData(urlString: String) {
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
                    self.currencyData.append(contentsOf: res)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch let err {
                    print(err)
                }
            }.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currency", for: indexPath) as! CurrencyTableViewCell
        
        cell.setCurrency(curr: currencyData[indexPath.row].cc, val: currencyData[indexPath.row].rate)
        
        return cell
    }
}
