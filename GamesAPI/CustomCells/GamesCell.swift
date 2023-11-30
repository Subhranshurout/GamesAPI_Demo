//
//  GamesCell.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 25/05/23.
//

import UIKit
import Kingfisher

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
    func prepareUI(game : GameDetails) {
        titleLbl.text = "Title : \(game.title)"
        platformLbl.text = "Platform : \(game.platform)"
        releaseLbl.text = "Release Date : \(game.release_date)"
        genreLbl.text = "Genre : \(game.genre)"
        imageLbl.kf.setImage(with: URL(string: game.thumbnail),placeholder: UIImage(named: "download"))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
