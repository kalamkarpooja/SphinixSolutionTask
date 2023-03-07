//
//  PopulationTableViewCell.swift
//  SphinixSolutionTask
//
//  Created by Mac on 06/03/23.
//

import UIKit

class PopulationTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var nationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
