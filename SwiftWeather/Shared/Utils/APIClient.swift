//
//  APIClient.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import Foundation

class APIClient<T:Decodable>{
    var apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY");
    
    func doGetAPI(forUrl:String, completion:@escaping(Result<T,Error>)->Void){
        guard let key = apiKey else {
            return;
        }

        let task = URLSession.shared.dataTask(with: URL(string: "\(forUrl)&appid=\(key)")!) { data, response, error in
            do{
                let forecast = try JSONDecoder().decode(T.self, from: data!);
                completion(.success(forecast));
            }catch let error{
                completion(.failure(error));
            }
        }
        
        task.resume();
    }
    
    func doPost(forUrl:String,data:T.Type, completion:@escaping(Result<T,Error>)->Void){
        var request = URLRequest(url: URL(string: forUrl)!);
        request.httpMethod = "POST";
        
        do {
          request.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error));
          return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                let forecast = try JSONDecoder().decode(T.self, from: data!);
                completion(.success(forecast));
            }catch let error{
                completion(.failure(error));
            }
        }
        
        task.resume();
    }
}
