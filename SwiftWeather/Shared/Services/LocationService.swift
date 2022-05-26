//
//  LocationService.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation
class LocationService{
    func getLocation(name:String, completion:@escaping(Result<[Location],Error>)->Void){
        APIClient<[Location]>().doGetAPI(forUrl: "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=10") { result in
            switch result{
            case .success(let res):
                completion(.success(res));
            case .failure(let error):
                completion(.failure(error));
            }
        }
    }
}
