//
//  PostListTableCell.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import UIKit

class PostListTableCell: UITableViewCell {

    static let identifier = "PostListTableCellIdentifier"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var post: Post? {
        didSet {
            if let post = post {
                updateCellData(post)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateCellData(_ post: Post) {
        idLabel.text = "\(post.id)"
        titleLabel.text = post.title
    }
}
