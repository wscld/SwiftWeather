//
//  DateUtils.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation
class DateUtils{
    static func fromMillis(millis:Double)->String{
        let date = Date(timeIntervalSince1970:millis)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM"
        
        return dateFormatter.string(from: date)
    }
    
    static func millisToDate(millis:Double)->Date{
        return Date(timeIntervalSince1970:millis)
    }
}
