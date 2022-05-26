//
//  AlertBuilder.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 26/05/22.
//

import Foundation
import UIKit

class AlertBuilder{
    static func buildAlert(title:String,subtitle:String) -> UIAlertController{
        let alert = UIAlertController(title: title, message:subtitle, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title:"Ok", style: UIAlertAction.Style.default, handler: nil))
        return alert;
    }
}
