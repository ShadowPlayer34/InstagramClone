//
//  NotficationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 1.03.23.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: UserNotification)
}

class NotficationFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotficationFollowEventTableViewCell"
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "kanye followed you."
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        addSubview(followButton)
        followButton.addTarget(self,
                               action: #selector(didTapFollowButton),
                               for: .touchUpInside)
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // photo, text, post button
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width - 5 - size,
                                    y: (contentView.height - buttonHeight) / 2,
                                    width: size,
                                    height: buttonHeight)
        label.frame = CGRect(x: profileImageView.rigth + 5,
                             y: 0,
                             width: contentView.width - size - profileImageView.width - 16,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    func configure(with model: UserNotification) {
        self.model = model
        profileImageView.image = UIImage(named: "avatar") // for test
        switch model.type {
        case .like(_):
           break
        case .follow(let state):
            switch state {
            case .following:
                // show unfollow button
                followButton.setTitle("Unfollow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            case .notFollowing:
                // show follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.backgroundColor = .link
                followButton.layer.borderWidth = 0
            }
            // configure button
        }
        label.text = model.text
//        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
}
