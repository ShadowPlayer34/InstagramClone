//
//  ViewController.swift
//  Instagram
//
//  Created by Андрей Худик on 12.02.23.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(IGFeedPostsTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostsTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        table.register(IGFeedPostActionsTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        handleNotAuthenticated()
        createMockModels()
    }
    
    private func createMockModels() {
        let user = User(username: "joe",
                        bio: "",
                        name: ("", ""),
                        profilePhoto: URL(string: "hhtps://www.google.com")!,
                        birthDate: Date(),
                        gender: .male,
                        counts: UserCount(followers: 45, following: 5, posts: 4),
                        joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 1...4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "joe\(x)",
                                        text: "Hello",
                                        createdDate: Date(),
                                        likes: []))
        }
        for _ in 0...4 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(provider: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            // actions
            return 1
        } else if subSection == 3 {
            // comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .actions, .primaryContent, .header: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x / 4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        if subSection == 0 {
            // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                cell.delegate = self
                cell.configure(with: user)
                return cell
            case .actions, .primaryContent, .comments: return UITableViewCell()
            }
        } else if subSection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostsTableViewCell
                cell.configure(with: post)
                return cell
            case .actions, .header, .comments: return UITableViewCell()
            }
        } else if subSection == 2 {
            // actions
            switch model.actions.renderType {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionsTableViewCell
                cell.delegate = self
                return cell
            case .header, .primaryContent, .comments: return UITableViewCell()
            }
        } else if subSection == 3 {
            // comments
            switch model.comments.renderType {
            case .comments(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostGeneralTableViewCell
                cell.configure(with: comment[indexPath.row])
                return cell
            case .actions, .primaryContent, .header: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Header
            return 55
        } else if subSection == 1 {
            // Post
            return tableView.width
        } else if subSection == 2 {
            // Actions
            return 50
        } else if subSection == 3 {
            // Comment row
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        if subSection == 3 {
            return 70
        }
        return 0
    }
}

extension HomeViewController: IGFeedPostHeaderTableViewCellDelegate, IGFeedPostActionsTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report", style: .destructive) { [weak self] _ in
            self?.reportPost()
        })
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    func didTapUsernameButton() {
        print("username")
    }
    
    private func reportPost() {
        
    }
    
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comment")
    }
    
    func didTapSendButton() {
        print("send")
    }
}
