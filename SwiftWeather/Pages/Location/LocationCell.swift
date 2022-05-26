//
//  LocationCell.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 26/05/22.
//

import Foundation
import UIKit
class LocationCell:UITableViewCell{
    
    @IBOutlet var cidadeLabel:UILabel?;
    @IBOutlet var estadoLabel:UILabel?;
    
    override class func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}
