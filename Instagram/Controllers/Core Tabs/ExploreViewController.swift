//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Андрей Худик on 12.02.23.
//

import UIKit

class ExploreViewController: UIViewController {

    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .secondarySystemBackground
        return bar
    }()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.titleView = searchBar
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: <#T##Double#>, height: <#T##Double#>)
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
