//
//  NowPlayingController.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit


class NowPlayingController: UIViewController, HomeCoordinator {
   
    
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private let viewModel: NowPlayingViewModel = .init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallBack()
        viewModel.getNowPlayingMovieList()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        view.addSubview(collection)
        collection.fillSuperviewSafeArea()
    }
    
    private func setupCallBack() {
        viewModel.callBack = {
            [weak self ]  type in
            guard let self else { return}
            switch type {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
            case .error(let message):
                self.showMessage(title: "Error", message: message)
            case .reloadData:
                self.collection.reloadData()
            }
        }
    }
}

extension NowPlayingController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionCell
        let imagePath = viewModel.movieImagePath(index: indexPath.item)
        cell.configure(imageName: imagePath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 76) / 3
        let cellHeight = cellWidth * 1.46
        return CGSizeMake(cellWidth, cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        14
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 24, bottom: 0, right: 24)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        18
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = viewModel.movieList[indexPath.item].id {
            showMovieDetailsController(movieId: movieId)
        }
    }
    
}
