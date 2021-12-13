//
//  NewsTableViewCell.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var contentsView: UIView!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        contentsView.layer.cornerRadius = 15
        contentsView.layer.masksToBounds = false
        contentsView.layer.shadowRadius = 6.0
        contentsView.layer.shadowOpacity = 0.3
        contentsView.layer.shadowColor = UIColor.gray.cgColor
        contentsView.layer.shadowOffset = CGSize(width: 0, height: 4)
    
        contentImageView.clipsToBounds = true
        contentImageView.layer.cornerRadius = 10
        contentImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 15
        ).cgPath
    }
}

