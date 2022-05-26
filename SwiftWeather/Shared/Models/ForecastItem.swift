//
//  WeatherItem.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 24/0¬5/22.
//

import Foundation
struct ForecastItem:Decodable{
    var main:WeatherItem;
    var weather:[WeatherDetail];
    var dt:Int
}
