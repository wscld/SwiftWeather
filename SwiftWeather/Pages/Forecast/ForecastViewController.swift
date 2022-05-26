//
//  ViewController.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 24/05/22.
//

import UIKit

class ForecastViewController: UIViewController {
    @IBOutlet var tableView:UITableView!;
    var forecast: Forecast?;
    var location:Location!;
    override func viewDidLoad() {
        super.viewDidLoad();
        tableView.delegate = self;
        tableView.dataSource = self;
        loadWeather();
        self.title = location.name;
    }
    
    func loadWeather(){
        WeatherService().getWeather(forLat: location.lat,forLon:location.lon) { result in
            switch result{
            case .success(let forecast):
                self.updateForecast(forecast: forecast)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(AlertBuilder.buildAlert(title: "Algo deu errado", subtitle: error.localizedDescription), animated: true);
                }
                
            }
        }
    }
    
    func updateForecast(forecast:Forecast){
        DispatchQueue.main.async {
            self.forecast = self.filterForecast(forecast: forecast);
            self.tableView.reloadData();
        }
    }
    
    func filterForecast(forecast:Forecast) -> Forecast{
        let calendar = Calendar.current;
        var f = forecast;
        f.list = forecast.list.filter{ calendar.component(.hour,from: DateUtils.millisToDate(millis: Double($0.dt))) == 12 }
        return f;
    }
}


extension ForecastViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension ForecastViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.list.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! ForecastCell;
        
        let temp = forecast!.list[indexPath.row].main.temp;
        let feelsLike = forecast!.list[indexPath.row].main.feels_like;
        
        cell.setColor(temp: temp);
        
        cell.temperatureLabel?.text = "\(temp)º";
        cell.feelsLikeLabel?.text = "\(feelsLike)º";
        cell.dateLabel?.text = DateUtils.fromMillis(millis: Double(forecast!.list[indexPath.row].dt));
        cell.setIcon(icon: forecast!.list[indexPath.row].weather[0].icon);
        return cell;
    }
    
    
}
