//
//  homeTVCell.swift
//  BetKing
//
//  Created by MAC on 22/07/21.
//

import UIKit

class homeTVCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leageTitleLBL: UILabel!
    @IBOutlet weak var dateTimeLBL: UILabel!
    @IBOutlet weak var firstTeamIMGview: UIImageView!
    @IBOutlet weak var secondTeamImgView: UIImageView!
    @IBOutlet weak var firstTeamName: UILabel!
    @IBOutlet weak var secondTeamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
