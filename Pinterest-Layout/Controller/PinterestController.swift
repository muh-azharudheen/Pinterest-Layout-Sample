//
//  ViewController.swift
//  Pinterest-Layout
//
//  Created by MS1 on 12/17/17.
//  Copyright © 2017 MS1. All rights reserved.
//

import UIKit

class PinterestController: UICollectionViewController {
    
    var posts : [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Pinterest"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 200, height: 300)
        }
        
        
        fetchPosts()
        
    }
    
    private func fetchPosts(){
        self.posts = Post.fetchPosts()
        self.collectionView?.reloadData()
    }
}




extension PinterestController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        cell.post = posts?[indexPath.item]
        return cell
    }
}

