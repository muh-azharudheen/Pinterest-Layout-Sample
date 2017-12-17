//
//  ViewController.swift
//  Pinterest-Layout
//
//  Created by MS1 on 12/17/17.
//  Copyright © 2017 MS1. All rights reserved.
//

import UIKit
import AVFoundation

class PinterestController: UICollectionViewController {
    
    var posts : [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Pinterest"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.identifier)
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
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

extension PinterestController: PinterestLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForPhotoAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if let post = posts?[indexPath.item] , let photo = post.image {
            let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
            let rect = AVMakeRect(aspectRatio: photo.size, insideRect: boundingRect)
            return rect.size.height
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, heightForCaptionAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        if let post = posts?[indexPath.item]{
            let topPadding : CGFloat = 8
            let bottomPadding: CGFloat = 12
            let captionFont = UIFont.systemFont(ofSize: 15)
            let captionHeight = self.height(for: post.caption!, with: captionFont, width: width)
            let profileImageHeight: CGFloat = 36.0
            
            let height = topPadding + captionHeight + topPadding + profileImageHeight + bottomPadding
            
            return height
        }
        return 0
    }
    
    func height(for text: String, with font: UIFont, width: CGFloat) -> CGFloat{
        let nsstring = NSString(string: text)
        let maxHeight = CGFloat(64.0)
        let textAttributes = [NSAttributedStringKey.font : font]
        let boundingRect = nsstring.boundingRect(with: CGSize(width: width, height: maxHeight), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil)
        return ceil(boundingRect.height)
        
    }
}

