//
//  ReviewController.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit

class ReviewControler: UIViewController {
    
    private lazy var tableReview: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.register(ReviewsCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.backgroundColor = .backgroundColorCustom
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let viewModel: ReviewViewModel
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallBack()
        viewModel.movieReviewsList()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        view.addSubview(tableReview)
        
        tableReview.fillSuperview()
    }
    
    private func setupCallBack() {
        viewModel.callBack = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
                self.tableReview.reloadData()
            case .error(let message):
                self.showMessage(title: "Error", message: message)
            case .deleteRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            case .reloadData:
                self.tableReview.reloadData()
            }
        }
    }
}

extension ReviewControler: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieReviewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewsCell
        cell.selectionStyle = .none
        cell.configure(data: viewModel.movieReviewModel[indexPath.row])
        return cell
    }
}
