//
//  WeatherService.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation
class WeatherService{
    
    func getWeather(forLat:Double,forLon:Double, completion:@escaping(Result<Forecast,Error>)->Void){
        APIClient<Forecast>().doGetAPI(forUrl: "https://api.openweathermap.org/data/2.5/forecast?lat=\(forLat)&lon=\(forLon)&units=metric") { result in
            switch result{
            case .success(let res):
                completion(.success(res));
            case .failure(let error):
                completion(.failure(error));
            }
        }
    }
}
