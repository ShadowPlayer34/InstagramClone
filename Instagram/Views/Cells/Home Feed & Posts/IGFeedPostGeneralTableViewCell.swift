//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 17.02.23.
//

import UIKit

/// Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostGeneralTableViewCell"
    
    private let comment: UILabel = {
        let label = UILabel()
        label.text = "Test"
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .systemBackground
        contentView.addSubview(comment)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: PostComment) {
        let fullText = NSMutableAttributedString(string: model.username, attributes: [.font: UIFont.boldSystemFont(ofSize: 17)])
        let commentText = NSMutableAttributedString(string: " " + model.text)
        fullText.append(commentText)
        comment.attributedText = fullText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        comment.frame = CGRect(x: 4.0, y: 0.0, width: contentView.width - 8, height: contentView.height)
    }

}
