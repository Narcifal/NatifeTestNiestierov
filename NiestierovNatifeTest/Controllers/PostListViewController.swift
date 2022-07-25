//
//  ViewController.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import UIKit

final class PostListViewController: UIViewController {

    //MARK: - IBOutlets -
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variables -
    private var recievedData = [Posts]()
    
    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getPostList()
    }
    
    //MARK: - IBActions -
    @IBAction private func sortPostLst(_ sender: UIBarButtonItem) {
        let alert = createActionSheet()
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Iternal -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.goToPostDetails {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let postDetailsVC = segue.destination as? PostDetailsViewController {
                    postDetailsVC.postId = recievedData[indexPath.row].postId
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate -
extension PostListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recievedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Cell.postTableViewCell, for: indexPath) as! PostTableViewCell
        
        let post = recievedData[indexPath.row]
        cell.configure(with: post, update: updateCellSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segue.goToPostDetails, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Private -
private extension PostListViewController {
    func setupTableView() {
        tableView.register(
            PostTableViewCell.nib(),
            forCellReuseIdentifier: Constants.Cell.postTableViewCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func getPostList() {
        let urlString = Constants.URL.postList

        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url, expecting: PostListData.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let postListData):
                self.updatePosts(posts: postListData.posts)
            }
        }
    }
    
    func updatePosts(posts: [Posts]) {
        DispatchQueue.main.async {
            self.recievedData = posts
            self.tableView.reloadData()
        }
    }
    
    func createActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let sortByRate = UIAlertAction(title: "Sort by Rate", style: .default) { (action) in
            self.recievedData = self.recievedData.sorted(by: { $0.likes_count > $1.likes_count})
            self.tableView.reloadData()
        }

        let sortByDate = UIAlertAction(title: "Sort by Date", style: .default) { (action) in
            
            self.recievedData = self.recievedData.sorted(by: { $0.timeshamp > $1.timeshamp})
            self.tableView.reloadData()
        }
        
        let sortByDefault = UIAlertAction(title: "Sort by Default", style: .default) { (action) in
            self.recievedData = self.recievedData.sorted(by: { $0.postId > $1.postId})
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        actionSheet.addAction(sortByRate)
        actionSheet.addAction(sortByDate)
        actionSheet.addAction(sortByDefault)
        actionSheet.addAction(cancelAction)
        
        return actionSheet
    }
    
    func updateCellSize() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
