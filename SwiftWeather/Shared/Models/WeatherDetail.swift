//
//  WeatherDetail.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 26/05/22.
//

import Foundation
struct WeatherDetail:Decodable{
    var id:Int;
    var main:String;
    var description:String;
    var icon:String;
}
