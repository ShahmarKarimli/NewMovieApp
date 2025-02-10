//
//  PopularCollectionCell.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//


import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(imageView)
        imageView.fillSuperview()
    }
    func configure(imageName: String?) {
        imageView.image = nil
        guard let imageName else {return}
        imageView.setImage(urlString: imageName)
    }
}
