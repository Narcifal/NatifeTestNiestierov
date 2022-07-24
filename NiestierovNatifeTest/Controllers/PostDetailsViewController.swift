//
//  PostDetailsViewController.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import UIKit

final class PostDetailsViewController: UIViewController {

    //MARK: - IBOutlets -
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    
    //MARK: - Variables -
    var postId: Int!
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailData()
    }
}

//MARK: - Private -
private extension PostDetailsViewController {
    func getDetailData() {
        let idString = postId.toString()
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(idString).json"

        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url, expecting: PostDetailsData.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let postDetail):
                self.updateDetail(postDetail: postDetail.post)
            }
        }
    }
    
    func updateDetail(postDetail: Post) {
        let urlString = postDetail.postImage
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.main.async {
            self.imageView.load(url: url)
            self.titleLabel.text = postDetail.title
            self.textLabel.text = postDetail.text
            self.dateLabel.text = postDetail.timeshamp.toDateString()
            self.likesCountLabel.text = postDetail.likes_count.toString()
        }
    }
}
