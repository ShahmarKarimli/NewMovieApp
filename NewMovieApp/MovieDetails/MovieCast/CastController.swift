//
//  CastController.swift
//  NewMovieApp
//
//  Created by Shahmar on 09.01.25.
//

import UIKit

class CastController: UIViewController {
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CastCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    let viewModel: CastViewModel
    
    init(viewModel: CastViewModel) {
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
        viewModel.movieCastList()
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundColorCustom
        view.addSubview(collection)
        collection.fillSuperview()
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
            case .deleteRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            case .reloadData:
                self.collection.reloadData()
            }
        }
    }
}

extension CastController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieCastModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CastCell
        cell.configure(data: viewModel.movieCastModel[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 135) / 2
        let cellHeight = cellWidth * 1.3
        return CGSizeMake(cellWidth, cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        65
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 29, bottom: 0, right: 41)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
}
