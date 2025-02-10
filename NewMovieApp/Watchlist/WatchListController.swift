//
//  WatchListController.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//
import UIKit

class WatchListController: UIViewController , HomeCoordinator{
   
    var callBack: ((Bool) -> Void)?
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.register(WatchListCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .backgroundColorCustom
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
   let viewModel: WatchListViewModel
    
    init(viewModel: WatchListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(title: "Watch list", image: .watchlist.resizeImage(newWidth: 24), selectedImage: .watchlist2.resizeImage(newWidth: 24))
        view.backgroundColor = .backgroundColorCustom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallBack()
        NotificationCenter.default.addObserver(self, selector: #selector(handleWatchListUpdate), name: .watchListUpdated, object: nil)
    }
  
    @objc private func handleWatchListUpdate() {
        viewModel.movieWatchList()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        
        view.addSubviews(table )
       
        table
            .top(view.safeAreaLayoutGuide.topAnchor, -24).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func setupCallBack() {
        viewModel.callBack = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .loading:
                self.view.showLoader()
            case .error(let message):
                self.showMessage(title: "Error", message: message)
            case .deleteRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            case .reloadData:
                self.table.reloadData()
            case .loaded:
                self.view.hideLoader()
            }
        }
    }
}

extension WatchListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.movieWatchListModel.isEmpty {
            showEmptyMessage()
        } else {
            removeEmptyMessage()
        }
        return viewModel.movieWatchListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WatchListCell
        cell.selectionStyle = .none
        cell.configure(data: viewModel.movieWatchListModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieId = viewModel.movieWatchListModel[indexPath.row].id {
            showMovieDetailsController(movieId: movieId)
        }
    }

    private func showEmptyMessage() {
        
        let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 8
        
        let imageView: UIImageView = {
            let image = UIImageView()
            image.image = .watchList
            image.contentMode = .scaleAspectFit
            image.width(76)
            image.height(76)
            return image
        }()
       
        let noWatchlistLabel1: UILabel = {
            let label = UILabel()
            label.textColor = .colorNo2
            label.text = "There Is No Movie Yet!"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            label.numberOfLines = 0
            return label
        }()
       
        let noWatchlistLabel2: UILabel = {
            let label = UILabel()
            label.textColor = .colorNo
            label.text = "Find your movie by Type title, categories, years, etc "
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.numberOfLines = 0
            return label
        }()
       
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(noWatchlistLabel1)
        stack.addArrangedSubview(noWatchlistLabel2)
        
        table.backgroundView = stack
        
        stack.centerX(table.centerXAnchor).0
            .centerY(table.centerYAnchor).0
            .trailing(view.trailingAnchor, -61)
    }

    private func removeEmptyMessage() {
        table.backgroundView = nil
    }
}
       
    
    
    
   
   

