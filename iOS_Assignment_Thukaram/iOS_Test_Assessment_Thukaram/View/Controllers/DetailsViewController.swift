//
//  DetailsViewController.swift
//  iOS_Test_Assessment_Thukaram
//
//  Created by apple on 4/25/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        idLabel.text = String(describing: (post?.id ?? 0))
        titleLabel.text = post?.title
        bodyLabel.text = post?.body
    }

}
