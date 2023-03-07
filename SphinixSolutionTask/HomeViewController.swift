//
//  HomeViewController.swift
//  SphinixSolutionTask
//
//  Created by Mac on 06/03/23.
//

import UIKit
import MapKit
import CoreLocation
class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var populationTableView: UITableView!
    @IBOutlet weak var usersCollectionView: UICollectionView!
    var users = [User]()
    var populations = [Datum]()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView()
        userJsonSeriallization()
        tableView()
        populationJsonDecoder()

    }
    func collectionView(){
        usersCollectionView.dataSource = self
        usersCollectionView.delegate = self
        let uinib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        self.usersCollectionView.register(uinib, forCellWithReuseIdentifier: "UserCollectionViewCell")
    }
    func tableView(){
        populationTableView.dataSource = self
        populationTableView.delegate = self
        let uinib = UINib(nibName: "PopulationTableViewCell", bundle: nil)
        self.populationTableView.register(uinib, forCellReuseIdentifier: "PopulationTableViewCell")
    }
    func userJsonSeriallization(){
        let urlString = "https://gorest.co.in/public/v2/users"
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let urlSession = URLSession(configuration: .default)
        let dataTask = urlSession.dataTask(with: urlRequest){data,response,error in
            if(error == nil){
                do{
                    let userJsonData = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                    for eachData in userJsonData{
                        let userId = eachData["id"] as! Int
                        let userName = eachData["name"] as! String
                        let userGender = eachData["gender"] as! String
                        let newUserObject = User(id: userId, name: userName, gender: userGender)
                        self.users.append(newUserObject)
                    }
                    DispatchQueue.main.async {
                        self.usersCollectionView.reloadData()
                    }
                    
                }catch{
                    print("error in fetching Data")
                }
            }
        }.resume()
    }
    func populationJsonDecoder(){
        let urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let urlSession = URLSession(configuration: .default)
        let dataTask = URLSession.shared.dataTask(with: urlRequest){data,response,error in
            print(response)
            if(error == nil) {
                do{
                    let jsonDecoder = JSONDecoder()
                    let jsonResponse = try jsonDecoder.decode(Population.self, from: data!)
                    self.populations = jsonResponse.data
                }catch{
                    print("error in fetching PopulationData")
                }
            }
            DispatchQueue.main.async {
                self.populationTableView.reloadData()
            }
        
        }.resume()
        
    }
}
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.usersCollectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.idLabel.text = "Id: \(users[indexPath.row].id)"
        cell.nameLabel.text = "Name: \(users[indexPath.row].name)"
        cell.genderLabel.text = "Gender: \(users[indexPath.row].gender)"
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = .init(genericCMYKCyan: 0, magenta: 1, yellow: 0, black: 1, alpha: 1)
         return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 260, height: 110)
    }
}
extension HomeViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        populations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.populationTableView.dequeueReusableCell(withIdentifier: "PopulationTableViewCell", for: indexPath) as! PopulationTableViewCell
        cell.nationLabel.text = populations[indexPath.row].nation
        cell.populationLabel.text = "Population: \(populations[indexPath.row].population)"
        cell.yearLabel.text = "Year: \(populations[indexPath.row].year)"
        cell.layer.borderWidth = 5
        cell.layer.cornerRadius = 3
        cell.layer.cornerCurve = .circular
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
}
