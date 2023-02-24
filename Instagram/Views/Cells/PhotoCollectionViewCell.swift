//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Андрей Худик on 22.02.23.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
         super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifire = "PhotoCollectionViewCell"
    
    public func configure(with model: String) {
        
    }
    
    public func configure(test imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
