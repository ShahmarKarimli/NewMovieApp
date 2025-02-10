//
//  CustomSegmentView.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//
import UIKit

class CustomSegmentView: UIView {
    
    var callBack: ((Int) -> Void)?
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColorCustom
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: items.enumerated().map({ index, text in
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.textColor = .white
            label.tag = index
            label.font = .systemFont(ofSize: 14)
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentAction(_:))))
            return label
        }))
        stack.spacing = 2
        stack.distribution = .fillEqually
        return stack
    }()
    private let selectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .selection
        return view
    }()
        
    private var selectionViewLeading: NSLayoutConstraint?
    
    private let items: [String]
    
    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
       setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(backView)
        backView.addSubviews(selectionView, stack)
        backView.fillSuperview()
        stack.fillSuperview(padding: .init(top: 2, left: 2, bottom: -2, right: -2))
        selectionViewLeading = selectionView
            .width(90).0
            .top(stack.bottomAnchor, 4).0
            .height(4).0
            .leading(stack.leadingAnchor).1
        
    }
    
    func moveToSegment(_ index: Int) {
        let x = stack.arrangedSubviews[index].frame.minX
        moveSelection(constant: x)
    }
    
    @objc func segmentAction(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else {return}
        moveSelection(constant: view.frame.minX)
        callBack?(view.tag)
    }
    func moveSelection(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            [weak self] in
            guard let self else { return}
            self.selectionViewLeading?.constant = constant
            self.layoutIfNeeded()
        }
    }
    
}



