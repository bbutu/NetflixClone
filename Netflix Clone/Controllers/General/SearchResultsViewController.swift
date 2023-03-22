//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Beka Buturishvili on 16.11.22.
//

import UIKit

protocol searchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(with model: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public weak var delegate: searchResultsViewControllerDelegate?
    
    public var titles: [Title] = [Title]()
    
    public let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: UIScreen.main.bounds.height / 4.5 - 10)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        view.addSubview(searchResultsCollectionView)
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title else{return}
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "This movie doesn't have overview"))
            case.failure(let error): 
                print(error.localizedDescription)
            }
        }
    }
    
    
}
