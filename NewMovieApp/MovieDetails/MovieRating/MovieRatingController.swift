//
//  RatingController.swift
//  MovieApplication
//
//  Created by Shahmar on 10.01.25.
//

import UIKit

class RatingController: UIViewController {
    
    
    var callBack: ((Double) -> Void)?
    
    private var rating = 5.0
        
    private lazy var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissBackView)))
        return view
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeImage: UIImageView = {
        let image = UIImageView()
        image.image = .close
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeImageTapped)))
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .ratinglabel
        label.text = "Rate this movie"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ratinglabel
        label.text = "5.0"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var ratingSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        slider.minimumTrackTintColor = .sliderMinimum
        slider.maximumTrackTintColor = .sliderMax
        slider.setThumbImage(.customThumb, for: .normal)
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 28
        button.setTitleColor(.button, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        button.backgroundColor = .buttonBack
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
           let step: Float = 0.5
           let roundedValue = round(sender.value / step) * step
           sender.value = roundedValue
           rating = Double(roundedValue)
           ratingLabel.text = String(format: "%.1f", roundedValue)
       }
    
    
    private func setupUI() {
        view.addSubviews(darkView, backView )
        
        backView.addSubviews(label,closeImage, ratingLabel, ratingSlider, confirmButton)
        
        darkView.fillSuperview()
        backView
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .bottom(view.bottomAnchor).0
            .topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeImage
            .top(backView.topAnchor, 14).0
            .leading(label.trailingAnchor, -5).0
            .trailing(backView.trailingAnchor, -15)
        label
            .leading(backView.leadingAnchor, 27.5).0
            .trailing(backView.trailingAnchor, -27.5).0
            .bottom(ratingLabel.topAnchor, -19).0
            .top(backView.topAnchor, 23)
        ratingLabel
            .top(label.bottomAnchor, 19).0
            .leading(backView.leadingAnchor, 27.5).0
            .trailing(backView.trailingAnchor, -27.5).0
            .bottom(ratingSlider.topAnchor, -19)
        ratingSlider
            .leading(backView.leadingAnchor, 48.5).0
            .trailing(backView.trailingAnchor, -48.5).0
            .bottom(confirmButton.topAnchor, -19)
        confirmButton
            .leading(backView.leadingAnchor, 77.5).0
            .trailing(backView.trailingAnchor, -77.5).0
            .height(56).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    @objc private func dismissButton() {
        dismiss(animated: true, completion: {
            [weak self] in
            guard let self else {return}
            self.callBack?(self.rating)
        })
    }
    @objc private func closeImageTapped() {
        dismiss(animated: true, completion: nil)
    }
    @objc private func dismissBackView() {
        dismiss(animated: true, completion: nil)
    }
}
