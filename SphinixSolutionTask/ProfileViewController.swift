//
//  ProfileViewController.swift
//  SphinixSolutionTask
//
//  Created by Mac on 06/03/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Name : Pooja Kalamkar"
        phoneNoLabel.text = "Phone no : +91-9067761107"
        phoneNoLabel.textColor = .black
    }
    

    

}
