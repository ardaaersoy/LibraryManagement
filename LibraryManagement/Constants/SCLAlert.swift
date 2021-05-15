//
//  SCLAlert.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import Foundation
import SCLAlertView

// MARK: - 
func ShowAlert(style: AlertStyle, subTitle: String) {
    switch style {
    case .success: SCLAlertView().showSuccess("Success", subTitle: subTitle)
    case .error: SCLAlertView().showError("Error", subTitle: subTitle)
    case .notice: SCLAlertView().showNotice("Notice", subTitle: subTitle)
    case .warning: SCLAlertView().showWarning("Warning", subTitle: subTitle)
    case .info: SCLAlertView().showInfo("Info", subTitle: subTitle)
    }
}

func ShowAlertWithAction(subTitle: String, completion: @escaping ()->Void) {
    let alert = SCLAlertView(appearance: SCLAlertView.SCLAppearance(showCloseButton: false))
    alert.addButton("No", backgroundColor: UIColor(named: "Blue"), textColor: .white) { }
    alert.addButton("Yes", backgroundColor: .white, textColor: UIColor(named: "DarkBlue")) { completion() }
    alert.showNotice("Notice", subTitle: subTitle)
}
