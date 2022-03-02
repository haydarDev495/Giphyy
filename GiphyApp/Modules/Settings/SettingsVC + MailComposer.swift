//
//  SettingsVC + MailComposer.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 21.02.22.
//

import UIKit

extension SettingsVC {
    
    func showLinkInSafary() {
        guard let url = URL(string: "https://giphy.com/") else { return }
        UIApplication.shared.open(url)
    }
    
    func showMailApp() {
        guard let url = URL(string: "mailto:apps@leonovs.com") else { return }
        UIApplication.shared.open(url)
    }
}
