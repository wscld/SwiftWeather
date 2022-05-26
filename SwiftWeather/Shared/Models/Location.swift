//
//  Location.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation
struct Location:Decodable,Encodable,Equatable{
    var name:String;
    var lat:Double;
    var lon:Double;
    var country:String?;
    var state:String?;
}
