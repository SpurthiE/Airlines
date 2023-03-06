//
//  DataModel.swift
//  Airlines
//
//  Created by spurthi.eshwarappa on 04/03/23.
//

import Foundation
import UIKit

protocol AirlineManagerDelegate {
    func didUpdateData(displayData: DisplayList?)
    func didFailwithError(error: Error)
}

class AirlineManager {
    
    var delegate: AirlineManagerDelegate?
    var model: [AirlineModel] = []
    let airlineURL = "https://api.qantas.com/flight/refData/airport"
    
    func fetchAirlineData() {
        let urlString = "\(airlineURL)"
        print(urlString)
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailwithError(error: error!)
                    return
                } else {
                    if let safeData = data {
                        if let displayData = self.parseJson(airlinedata: safeData) {
                            self.delegate?.didUpdateData(displayData: displayData)
                        }
                    }
                }
            }
            task.resume()
        }

    }

    func parseJson(airlinedata: Data) -> DisplayList? {
        let decoder = JSONDecoder()
        var airportname = ""
        var country = ""
        var timeZone = ""
        var cityName = ""
        do {
            let decodedData = try decoder.decode(AirlineList.self, from: airlinedata)
            ///Displaying 25 elements because of unavailibity of pagination(as a sample because api giving 7K+ data)
            for i in 1...25 {
                airportname = decodedData[i].airportName
                country = decodedData[i].country.countryName ?? ""
                timeZone = decodedData[i].city.timeZoneName ?? ""
                cityName = decodedData[i].city.cityName ?? ""
                model.append(AirlineModel(airportName: airportname, countryName: country, cityName: cityName, timeZoneName: timeZone))
            }
            return model
        } catch {
            delegate?.didFailwithError(error: error)
            return nil
        }
    }
}
