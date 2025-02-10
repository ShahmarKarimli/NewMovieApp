//
//  ReviewCell.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit
protocol ReviewCellData {
    var authorName: String {get}
    var avatarURL: String?{get}
    var reviewContent: String {get}
    var userRating: Double { get}
}

class ReviewsCell: UITableViewCell{
    
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = .avatar
        image.layer.cornerRadius = 22
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let reviewContentLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .backgroundColorCustom
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customTint
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    
    lazy var imageRatingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [avatarImageView, userRatingLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    lazy var labelStack: UIStackView = {
        let labelStack = UIStackView(arrangedSubviews:[fullNameLabel, reviewContentLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 5
        return labelStack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.addSubviews(imageRatingStack, labelStack)
        contentView.backgroundColor = .backgroundColorCustom
        imageRatingStack
            .top(contentView.topAnchor, 20).0
            .leading(contentView.leadingAnchor, 20).0
            .width(44).0
            .height(76)
        labelStack
            .top(imageRatingStack.topAnchor).0
            .leading(imageRatingStack.trailingAnchor, 12).0
            .trailing(contentView.trailingAnchor, -24).0
            .bottom(contentView.bottomAnchor, -20)
        contentView
            .heightAnchor.constraint(greaterThanOrEqualToConstant: 96).isActive = true
            
    }
    
    func configure(data: ReviewCellData) {
        fullNameLabel.text = data.authorName
        reviewContentLabel.text = data.reviewContent
        userRatingLabel.text = "\(data.userRating)"
        avatarImageView.setImage(urlString: data.avatarURL)
    }
   
}

