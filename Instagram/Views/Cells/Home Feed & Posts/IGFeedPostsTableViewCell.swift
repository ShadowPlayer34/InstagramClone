//
//  IGFeedPostsTableViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 17.02.23.
//

import UIKit
import SDWebImage
import AVFoundation

/// Cell for primary post content
final class IGFeedPostsTableViewCell: UITableViewCell {
    static let identifier = "IGFeedPostsTableViewCell"
    private var player: AVPlayer?
    private let avLayer = AVPlayerLayer()
    
    private  let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .secondarySystemBackground
        contentView.layer.addSublayer(avLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        // configure the cell
        postImageView.image = UIImage(named: "test")
        return
        
        switch post.postType {
        case .photo:
            postImageView.sd_setImage(with: post.postURL, completed: nil)
            // show photo
        case .video:
            player = AVPlayer(url: post.postURL)
            avLayer.player = player
            avLayer.player?.volume = 0
            avLayer.player?.play()
            // play video
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}

