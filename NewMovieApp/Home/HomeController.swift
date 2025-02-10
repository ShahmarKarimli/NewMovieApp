//
//  HomeController.swift
//  NewMovieApp
//
//  Created by Shahmar on 08.01.25.
//

import UIKit

class HomeController: UIViewController {
    
    private let segmentView = CustomSegmentView(items: [
        "Now Playing",
        "Upcoming",
        "Top rated",
        "Popular"
    ])
    
    private lazy var subControllers: [UIViewController] = []
    
    private func configureSubControllers() {
        let nowPlayingController = NowPlayingController()
        let upComingController = UpComingController()
        let topRatedController = TopRatedController()
        let popularController = PopularController()
        subControllers = [nowPlayingController, upComingController, topRatedController, popularController]
    }
    
    
    private var currentIndex = 0
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(title: "Home", image: .home.resizeImage(newWidth: 24), selectedImage: .home2.resizeImage(newWidth: 24))
        view.backgroundColor = .backgroundColorCustom
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        view.addSubviews(label, segmentView, pageController.view)
        label
            .top(view.safeAreaLayoutGuide.topAnchor, 10).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(segmentView.topAnchor, -24)
        segmentView
            .top(label.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 20).0
            .trailing(view.trailingAnchor, -10).0
            .bottom(pageController.view.topAnchor, -24)
        segmentView.callBack = { [weak self] index in
            guard let self else { return}
            self.moveToController(index)
        }
        
        segmentView.backgroundColor = .backgroundColorCustom
        pageController.view.backgroundColor = .white
        pageController.view
            .top(segmentView.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 16).0
            .trailing(view.trailingAnchor, -16).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
        addChild(pageController)
        pageController.dataSource = self
        pageController.delegate = self
        configureData()
    }
    
    private func configureData() {
        configureSubControllers()
        pageController.setViewControllers([subControllers[0]], direction: .forward, animated: false)
        
    }
    func moveToController(_ index: Int) {
        let controller = subControllers[index]
        pageController.setViewControllers([controller], direction:  index < currentIndex ? .reverse : .forward, animated: true)
        currentIndex = index
    }
}

extension HomeController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
