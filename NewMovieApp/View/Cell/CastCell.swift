//
//  CastCell.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//
import UIKit

protocol CastCellData {
    var authorProfileName: String {get}
    var imageURL: String? {get}
}

class CastCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 50
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    lazy var labelStack: UIStackView = {
        let labelStack = UIStackView(arrangedSubviews:[imageView, nameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 8
        return labelStack
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
        contentView.addSubviews(imageView, nameLabel)
        imageView
            .top(contentView.topAnchor).0
            .width(100).0
            .height(100).0
            .leading(contentView.leadingAnchor)
        nameLabel
            .top(imageView.bottomAnchor, 8).0
            .leading(contentView.leadingAnchor, 10).0
            .trailing(contentView.trailingAnchor, -10)
    }
    func configure(data: CastCellData) {
        nameLabel.text = data.authorProfileName
        imageView.setImage(urlString: data.imageURL)
    }
    
}
