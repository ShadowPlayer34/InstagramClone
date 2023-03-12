//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Андрей Худик on 22.02.23.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar") // for test
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
       let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Andrew Hudik"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the first account!"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addButtonsActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    func configure(with model: User) {
        postsButton.setTitle("\(model.counts.posts)\nPosts", for: .normal)
        followersButton.setTitle("\(model.counts.followers)\nFollowers", for: .normal)
        followingButton.setTitle("\(model.counts.following)\nFollowing", for: .normal)
    }
    
    private func addButtonsActions() {
        postsButton.addTarget(self,
                              action: #selector(didTapPostsButton),
                              for: .touchUpInside)
        followersButton.addTarget(self,
                              action: #selector(didTapFollowersButton),
                              for: .touchUpInside)
        followingButton.addTarget(self,
                              action: #selector(didTapFollowingButton),
                              for: .touchUpInside)
        editProfileButton.addTarget(self,
                              action: #selector(didTapEditProfileButton),
                              for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotoSize = width / 4.0
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize / 2.0
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        let buttonHeight = profilePhotoSize / 2.0
        let countButtonWidth = (width - 10 - profilePhotoSize) / 3.0
        postsButton.frame = CGRect(x: profilePhotoImageView.rigth, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postsButton.rigth, y: 5, width: countButtonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.rigth, y: 5, width: countButtonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: postsButton.left, y: 5 + buttonHeight, width: countButtonWidth * 3.0, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: profilePhotoImageView.bottom + 5, width: width - 10, height: 50).integral
        let bioSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom + 5, width: width - 10, height: bioSize.height).integral
    }
    
    // MARK: - Actions
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
