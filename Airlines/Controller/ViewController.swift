//
//  ViewController.swift
//  Airlines
//
//  Created by spurthi.eshwarappa on 04/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    var airlineManger = AirlineManager()
    var airlineObj = AirlineManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        airlineManger.fetchAirlineData()
        airlineManger.delegate = self
        navigationItem.title = "Airlines Details"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loader.startAnimating()
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airlineObj.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = airlineObj.model[indexPath.row].airportName
        cell.detailTextLabel?.text = airlineObj.model[indexPath.row].countryName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        DispatchQueue.main.async {
            secondViewController.cityName.text =  self.airlineObj.model[indexPath.row].cityName
            secondViewController.timeZone.text =  self.airlineObj.model[indexPath.row].timeZoneName
        }
        navigationController?.pushViewController(secondViewController, animated: true)
    }

}

extension ViewController: AirlineManagerDelegate {
    func didUpdateData(displayData: DisplayList?) {
        DispatchQueue.main.async {
            self.airlineObj.model = displayData ?? [AirlineModel(airportName: "", countryName: "", cityName: "", timeZoneName: "")]
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.loader.isHidden = true
        }
    }

    func didFailwithError(error: Error) {
        print(error)
    }
}
