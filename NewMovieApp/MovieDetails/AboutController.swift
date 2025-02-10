//
//  AboutController.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//
import UIKit

struct AboutMovieCellData {
    let description: String
}

class AboutController: UIViewController {
    
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 12, weight: .regular)
        textView.textAlignment = .left
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        textView.backgroundColor = .backgroundColorCustom
        view.addSubview(textView)
        textView
            .top(view.topAnchor).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
            
    }
    
    func configure(data: String) {
        textView.text = data
    }
}

    
