//
//  SettingsVC + MailComposer.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 21.02.22.
//

import Foundation
import MessageUI

extension SettingsVC : MFMailComposeViewControllerDelegate {
    
    func showLinkInSafary() {
        guard let url = URL(string: "https://giphy.com/") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showMailComporser() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.setSubject("Feedback")
            mailComposerVC.setToRecipients(["apps@leonovs.com"])
            present(UINavigationController.init(rootViewController: mailComposerVC), animated: true)
        } else {
            guard let url = URL(string: "https://www.google.com/intl/ru/gmail/about/") else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
