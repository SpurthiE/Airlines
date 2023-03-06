//
//  DescriptionViewController.swift
//  Airlines
//
//  Created by spurthi.eshwarappa on 04/03/23.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var timeZone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Flight Details"
        // Do any additional setup after loading the view.
    }

}
