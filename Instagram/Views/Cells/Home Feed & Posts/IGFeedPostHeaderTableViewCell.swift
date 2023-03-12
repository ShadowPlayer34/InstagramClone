//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 17.02.23.
//

import UIKit
import SDWebImage

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
    func didTapUsernameButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostHeaderTableViewCell"
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameButton)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self,
                             action: #selector(didTapMoreButton),
                             for: .touchUpInside)
        usernameButton.addTarget(self,
                                 action: #selector(didTapUsernameButton),
                                 for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    @objc private func didTapUsernameButton() {
        delegate?.didTapUsernameButton()
    }
    
    public func configure(with model: User) {
        // configure the cell
        self.usernameButton.setTitle(model.username, for: .normal)
        self.profileImageView.image = UIImage(named: "avatar") // for test
//        self.profileImageView.sd_setImage(with: model.profilePhoto)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 16
        profileImageView.frame = CGRect(x: 2, y: 8, width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        usernameButton.frame = CGRect(
            x: profileImageView.rigth + 10,
            y: 2,
            width: contentView.width - (size + 2) - 15 - size,
            height: contentView.height - 4
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameButton.setTitle(nil, for: .normal)
        profileImageView.image = nil
    }

}
