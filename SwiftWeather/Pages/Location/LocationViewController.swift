//
//  LocationViewController.swift
//  SwiftWeather
//
//  Created by Wesley Caldas on 25/05/22.
//

import UIKit

class LocationViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!;
    @IBOutlet var tableView:UITableView!;
    var searchTask: DispatchWorkItem?
    var locations:[Location]?;
    var loading:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        searchBar.delegate = self;
        tableView.delegate = self;
        tableView.dataSource = self;
        locations = loadHistory();
    }
    
    func findLocations(forName:String){
        self.loading = true;
        LocationService().getLocation(name: forName) { result in
            switch result{
            case(.success(let locations)):
                self.updateLocations(locations: locations);
                self.loading = false;
            case(.failure(let error)):
                DispatchQueue.main.async {
                    self.present(AlertBuilder.buildAlert(title: "Algo deu errado", subtitle: error.localizedDescription), animated: true);
                }
                self.loading = false;
            }
        }
    }
    
    func saveHistory(location:Location){
        var locations = loadHistory();
        
        if (locations.filter({ $0.name == location.name }).count == 0) {
            locations.append(location);
            let defaults = UserDefaults.standard;
            try? defaults.encode(locations, forKey: "loc1");
        }
    }
    
    func loadHistory()->[Location]{
        let defaults = UserDefaults.standard;
        do{
            return try defaults.decode([Location].self, forKey: "loc1");
        }catch(let error){
            print(error);
        }
        return [Location]()
    }
    
    func updateLocations(locations:[Location]){
        DispatchQueue.main.async {
            self.locations = locations;
            self.tableView.reloadData();
        }
    }
    
}

extension LocationViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations![indexPath.row];
        saveHistory(location:location)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForecastViewController") as? ForecastViewController;
        vc?.location = location;
        self.navigationController?.pushViewController(vc!, animated: true);
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension LocationViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationCell;
        cell.cidadeLabel?.text = locations![indexPath.row].name;
        cell.estadoLabel?.text = locations![indexPath.row].state;
        return cell;
    }
}

extension LocationViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.findLocations(forName: searchBar.text!.urlEncoded);
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.locations = self.loadHistory();
                self.tableView.reloadData();
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

extension String {
    var urlEncoded: String! {
        return self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)?.replacingOccurrences(of: "%20", with: "+")
    }
}


extension UserDefaults {
    func decode<T: Decodable>(_ type: T.Type, forKey defaultName: String) throws -> T {
        try JSONDecoder().decode(T.self, from: data(forKey: defaultName) ?? .init())
    }
    func encode<T: Encodable>(_ value: T, forKey defaultName: String) throws {
        try set(JSONEncoder().encode(value), forKey: defaultName)
    }
}
