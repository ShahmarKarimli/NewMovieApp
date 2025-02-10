//
//  MovieDetailsController.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit

class MovieDetailsController: UIViewController, HomeCoordinator {

    
    
    
    private let segmentView = CustomSegmentView(items: [
        "About Movie",
        "Reviews",
        "Cast"
    ])
    
    
    private lazy var subControllers: [UIViewController] = []
    
    private func configureSubControllers() {
        let aboutController = AboutController()
        aboutController.configure(data: viewModel.overview ?? "")
        let reviewController = ReviewControler(viewModel: ReviewViewModel(movieId: viewModel.movieId))
        let castController = CastController(viewModel: CastViewModel(movieId: viewModel.movieId))
        subControllers = [aboutController, reviewController, castController]
    }
    
    
    private var currentIndex = 0
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
    
    private let backImage: UIImageView = {
        let backImage = UIImageView()
        backImage.clipsToBounds = true
        backImage.layer.cornerRadius = 10
        backImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        backImage.contentMode = .scaleAspectFill
        return backImage
    }()
    
    private let posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 16
        posterImage.contentMode = .scaleAspectFill
        return posterImage
    }()
    
    private lazy var ratingBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .rating
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ratingLabelTapped)))
        return view
    }()
    
    private let separatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .ratingIcon
        icon.width(16)
        //icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private lazy var ratingStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        stack.axis = .horizontal
        stack.spacing = 2
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
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private lazy var releaseStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [releaseIcon, releaseDateLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    private let genreIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .genreIcon.resizeImage(newWidth: 16)
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private lazy var genreStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [genreIcon, genresLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    private let timeIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = .timeIcon.resizeImage(newWidth: 16)
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private lazy var timeStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeIcon, timeLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    var viewModel: MovieDetailsViewModel
    
    
    init(viewModel: MovieDetailsViewModel) {
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
        setupNav()
        viewModel.fetchData()
    }
    
    @objc private func ratingLabelTapped() {
        showRatingDetails(callBack: {
            [weak self]  rating in
            guard let self else { return }
            self.viewModel.movieAddRatingList(rating: rating)
        })
    }
    
    private func setupNav() {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationItem.title = "Detail"
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    private func setRightBarButton() {
        guard let watchListState = viewModel.watchListState else {
            navigationItem.rightBarButtonItem = nil
            return
        }
        let watchListButton = UIBarButtonItem(
            image:  UIImage(systemName: watchListState ? "bookmark.fill" : "bookmark"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
        navigationItem.rightBarButtonItem = watchListButton
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        view.addSubviews(backImage, posterImage, nameLabel, genreStack, releaseStack, timeStack, separatorView1, separatorView2, segmentView, pageController.view)
        view.addSubview(ratingBackView)
        ratingBackView.addSubview(ratingStack)
        backImage
            .top(view.safeAreaLayoutGuide.topAnchor, 20).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .height(210)
        posterImage
            .leading(backImage.leadingAnchor, 29).0
            .top(backImage.bottomAnchor, -60).0
            .width(95).0
            .height(120)
        ratingBackView
            .bottom(backImage.bottomAnchor, -9).0
            .trailing(backImage.trailingAnchor, -11).0
            .width(54).0
            .height(24)
        nameLabel
            .leading(posterImage.trailingAnchor, 12).0
            .trailing(view.trailingAnchor, -29).0
            .top(backImage.bottomAnchor, 12)
        releaseStack
            .top(posterImage.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 63).0
            .height(16)
        separatorView1
            .top(releaseIcon.topAnchor).0
            .leading(releaseStack.trailingAnchor, 12).0
            .width(1).0
            .height(16)
        timeStack
            .top(releaseStack.topAnchor).0
            .leading(separatorView1.trailingAnchor, 12).0
            .height(16)
        separatorView2
            .top(releaseStack.topAnchor).0
            .leading(timeStack.trailingAnchor, 12).0
            .width(1).0
            .height(16)
        genreStack
            .top(releaseStack.topAnchor).0
            .leading(separatorView2.trailingAnchor, 12).0
            .height(16)
        ratingStack
            .leading(ratingBackView.leadingAnchor, 8).0
            .trailing(ratingBackView.trailingAnchor, -8).0
            .top(ratingBackView.topAnchor, 3).0
            .bottom(ratingBackView.bottomAnchor, -3)
        segmentView
            .top(genresLabel.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 27).0
            .trailing(view.trailingAnchor, -78).0
            .height(41)
        segmentView.callBack = { [weak self] index in
            guard let self else { return}
            self.moveToController(index)
            view.layoutIfNeeded()
        }
        
        segmentView.backgroundColor = .backgroundColorCustom
        
        pageController.view.backgroundColor = .backgroundColorCustom
        pageController.view
            .top(segmentView.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 29).0
            .trailing(view.trailingAnchor, -29).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        addChild(pageController)
        pageController.dataSource = self
        pageController.delegate = self
    }
    
    
    func moveToController(_ index: Int) {
        let controller = subControllers[index]
        pageController.setViewControllers([controller], direction:  index < currentIndex ? .reverse : .forward, animated: true)
        currentIndex = index
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
                self.configureData()
            case .addRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            case .accountStates:
                self.setRightBarButton()
            }
        }
    }

    private func configureData() {
        backImage.setImage(urlString: viewModel.backImagePath)
        posterImage.setImage(urlString: viewModel.posterImagePath)
        nameLabel.text = viewModel.titleName
        releaseDateLabel.text = viewModel.releaseDate
        timeLabel.text = viewModel.movieTime
        genresLabel.text = viewModel.genreMovie
        ratingLabel.text = viewModel.ratingVote
        configureSubControllers()
        pageController.setViewControllers([subControllers[0]], direction: .forward, animated: false)
    }
    
    @objc func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc private func rightBarButtonTapped() {
        viewModel.addToDetailsWatchList()
        NotificationCenter.default.post(name: .watchListUpdated, object: nil)//new
    }
    
}

extension MovieDetailsController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = subControllers.firstIndex(of: viewController),
              index > 0 else { return nil}
        currentIndex = index - 1
        segmentView.moveToSegment(currentIndex)
        return subControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = subControllers.firstIndex(of: viewController),
              index < subControllers.count - 1 else { return nil}
        currentIndex = index + 1
        segmentView.moveToSegment(currentIndex)
        return subControllers[currentIndex]
    }
}


