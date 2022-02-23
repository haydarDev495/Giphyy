//
//  SettingCell.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 18.02.22.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var settingsLabel: UILabel!
    
    func configure(text: String ) {
        self.settingsLabel.text = text
    }
}
