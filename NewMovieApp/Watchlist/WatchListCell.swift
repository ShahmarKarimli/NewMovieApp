//
//  WatchListCell.swift
//  NewMovieApp
//
//  Created by Shahmar on 12.01.25.
//
import UIKit

protocol WatchListCellData {
    var imageName: String {get}
    var name: String {get}
    var ratingSearch: String? {get}
    var releaseSearchDate: String {get} 
}

class WatchListCell: UITableViewCell {
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .ratingIcon
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .rat
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    private let releaseIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .releaseIcon.resizeImage(newWidth: 16)
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    private lazy var releaseStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [releaseIcon, releaseDateLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .backgroundColorCustom
        contentView.addSubviews(posterImageView, nameLabel, ratingStack, releaseStack)
        
        posterImageView
            .leading(contentView.leadingAnchor, 29).0
            .trailing(nameLabel.leadingAnchor, -12).0
            .width(95).0
            .height(120)
        nameLabel
            .top(posterImageView.topAnchor).0
            .trailing(contentView.trailingAnchor, -39).0
            .width(200).0
            .height(24)
        ratingStack
            .leading(nameLabel.leadingAnchor).0
            .top(nameLabel.bottomAnchor, 14).0
            .width(39).0
            .height(16)
        releaseStack
            .leading(nameLabel.leadingAnchor).0
            .top(ratingStack.bottomAnchor, 4).0
            .width(55).0
            .height(18)
    }
    
    func configure(data: WatchListCellData) {
        posterImageView.setImage(urlString: data.imageName)
        nameLabel.text = data.name
        ratingLabel.text = data.ratingSearch
        releaseDateLabel.text = data.releaseSearchDate
    }
}
