//
//  ForecastCell.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation
import UIKit
class ForecastCell:UITableViewCell{
    @IBOutlet var forecastView:UIView?;
    @IBOutlet var dateLabel:UILabel?;
    @IBOutlet var temperatureLabel:UILabel?;
    @IBOutlet var feelsLikeLabel:UILabel?;
    
    override class func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    func setColor(temp:Float){
        self.forecastView?.layer.cornerRadius = 10;
        self.forecastView?.layer.masksToBounds = true;
        if(temp<=25){ // frio
            forecastView?.backgroundColor = hexStringToUIColor(hex: "#003aad");
        }else if(temp<=30){ // normal
            forecastView?.backgroundColor = hexStringToUIColor(hex: "#00b4ff");
        }else if(temp>30){ // quente
            forecastView?.backgroundColor = hexStringToUIColor(hex: "#ecc793");
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
