//
//  PostTableViewCell.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var postText: UILabel!
    @IBOutlet private weak var likes: UILabel!
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var expandButton: UIButton!
    
    //MARK: - Constants -
    private let expandButtonTitle = "Expand"
    private let collapseButtonTitle = "Collapse"
    
    //MARK: - Variables -
    var cellUpdate: (() -> Void)!
    
    //MARK: - Iternal -
    func configure(with postList: Posts, update: @escaping () -> Void) {
        self.title.text = postList.title
        postText.text = postList.preview_text
        likes.text = postList.likes_count.toString()
        self.date.text = postList.timeshamp.toDateString()
        
        expandButton.isHidden = isExpandButtonNeeded()
        cellUpdate = update
    }
    
    //MARK: - Static -
    static func nib() -> UINib {
        return UINib(nibName: Constants.Cell.postTableViewCell, bundle: nil)
    }
    
    //MARK: IBActions
    @IBAction private func expandStateButtonTapped(_ sender: UIButton) {
        let isExpanded = expandButton.currentTitle == expandButtonTitle
        changeButtonTitle(isExpanded: isExpanded)
        cellUpdate()
    }
}

//MARK: - Private -
private extension PostTableViewCell {
    func isExpandButtonNeeded() -> Bool{
        return postText.maxNumberOfLines - 1 <= 2
    }
    
    func changeButtonTitle(isExpanded: Bool) {
        let buttonTitle = isExpanded ? collapseButtonTitle : expandButtonTitle
        expandButton.setTitle(buttonTitle, for: .normal)
        postText.numberOfLines = isExpanded ? 0 : 2
    }
}
