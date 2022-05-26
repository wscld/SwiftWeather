//
//  Forecast.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 24/05/22.
//

import Foundation
struct Forecast:Decodable{
    var list:[ForecastItem];
}
