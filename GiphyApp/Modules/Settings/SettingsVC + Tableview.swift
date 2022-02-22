//
//  SettingsVC + Tableview.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 18.02.22.
//

import UIKit

extension SettingsVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.configure(text: "Contact Us: apps@leonovs.com")
        }else {
            cell.configure(text: "The gifs is from: Giphy.com")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            showMailApp()
        } else {
            showLinkInSafary()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
