//
//  PostTableViewCell.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    //MARK: - Iternal -
    func configure(with postList: Posts) {
        self.title.text = postList.title
        postText.text = postList.preview_text
        likes.text = postList.likes_count.toString()
        self.date.text = postList.timeshamp.toDateString()

        expandButton.isHidden = isExpandButtonNeeded()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PostTableViewCell", bundle: nil)
    }
    
    //MARK: - Private -
    private func isExpandButtonNeeded() -> Bool{
        return postText.maxNumberOfLines <= 2
    }
    
    //MARK: IBActions
    @IBAction func expandText(_ sender: UIButton) {
        if expandButton.currentTitle == "Expand" {
            expandButton.setTitle("Collapse", for: .normal)
            postText.numberOfLines = 0
        } else {
            expandButton.setTitle("Expand", for: .normal)
            postText.numberOfLines = 2
        }
    }
}
