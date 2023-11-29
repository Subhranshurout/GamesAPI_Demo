//
//  GamesCell.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit

class GamesCell: UITableViewCell {

    @IBOutlet var imageLbl: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var genreLbl: UILabel!
    @IBOutlet var platformLbl: UILabel!
    @IBOutlet var releaseLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageLbl.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
