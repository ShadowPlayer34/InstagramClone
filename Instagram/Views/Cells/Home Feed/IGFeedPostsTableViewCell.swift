//
//  IGFeedPostsTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 17.02.23.
//

import UIKit

final class IGFeedPostsTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
    }

}

