//
//  SearchController.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import UIKit

class SearchController: UIViewController , HomeCoordinator{
    private let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 42))
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .selection
        field.layer.cornerRadius = 16
        field.textAlignment = .left
        field.textColor = .white
        field.leftView = paddingView
        field.leftViewMode = .always
        field.font = .systemFont(ofSize: 14, weight: .regular)
        field.placeholder = "Search for a movie..."
        return field
    }()
    
    private let searchIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .searchicon
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        icon.isUserInteractionEnabled = true
        return icon
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(SearchItemCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .backgroundColorCustom
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.isHidden = true
        return label
    }()
    
    private let noResultImageView: UIImageView = {
        let image = UIImageView()
        image.image = .noResults
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    private lazy var noResultsLabel1: UILabel = {
        let label = UILabel()
        label.text = "We Are Sorry, We Can Not Find The Movie :("
        label.numberOfLines = 0
        label.textColor = .colorNo2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private lazy var noResultsLabel2: UILabel = {
        let label = UILabel()
        label.text = "Find your movie by Type title, categories, years, etc "
        label.numberOfLines = 0
        label.textColor = .colorNo
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(title: "Search", image: .search.resizeImage(newWidth: 24), selectedImage: .search2.resizeImage(newWidth: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallBack()
        addSearchIconTapGesture()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        
        view.addSubviews(textField, searchIcon, paddingView, table, label )
        label.addSubviews(noResultImageView, noResultsLabel1, noResultsLabel2)
        textField
            .top(view.safeAreaLayoutGuide.topAnchor, 40).0
            .leading(view.leadingAnchor, 29).0
            .trailing(view.trailingAnchor, -15).0
            .height(42)
        searchIcon
            .top(textField.topAnchor, 13).0
            .trailing(textField.trailingAnchor, -15).0
            .width(16).0
            .height(16)
        table
            .top(textField.bottomAnchor, 24).0
            .leading(textField.leadingAnchor).0
            .trailing(textField.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        label
            .top(textField.bottomAnchor, 144).0
            .width(252).0
            .height(190).0
            .centerX(view.centerXAnchor)
        noResultImageView
            .top(label.topAnchor).0
            .bottom(noResultsLabel1.topAnchor, -16).0
            .width(76).0
            .centerX(label.centerXAnchor)
        noResultsLabel1
            .leading(label.leadingAnchor, 32).0
            .trailing(label.trailingAnchor, -32).0
            .bottom(noResultsLabel2.topAnchor, -8)
        noResultsLabel2
            .leading(label.leadingAnchor, 32).0
            .trailing(label.trailingAnchor, -32).0
            .bottom(label.bottomAnchor)
        
    }
    
    private func setupCallBack() {
        viewModel.callBack = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
            case .error(let message):
                self.showMessage(title: "Error", message: message)
            case .deleteRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            case .reloadData:
                self.updateSearch()
            }
        }
    }
    
    private func addSearchIconTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchIcon))
        searchIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapSearchIcon() {
        guard let query = textField.text, !query.isEmpty else {
            showMessage(title: "Error", message: "Please enter a search term.")
            return
        }
        viewModel.querySearch = query
        viewModel.movieSearchList()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text, !query.isEmpty else {
            viewModel.movieSearchModel.removeAll()
            updateSearch()
            return
        }
        viewModel.querySearch = query
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        perform(#selector(performSearch), with: nil, afterDelay: 0.5)
    }
    @objc private func performSearch() {
        viewModel.movieSearchList()
    }
    private func updateSearch() {
        if viewModel.movieSearchModel.isEmpty {
            label.isHidden = false
            table.isHidden = true
        } else {
            label.isHidden = true
            table.isHidden = false
            table.reloadData()
        }
    }
    
}
extension SearchController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieSearchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchItemCell
        cell.selectionStyle = .none
        cell.configure(data: viewModel.movieSearchModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieId = viewModel.movieSearchModel[indexPath.row].id {
            showMovieDetailsController(movieId: movieId)
        }
    }
}
extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSearchIcon()
        textField.resignFirstResponder()
        return true
    }
}

