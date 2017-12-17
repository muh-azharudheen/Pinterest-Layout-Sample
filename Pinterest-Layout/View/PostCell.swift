//
//  PostCell.swift
//  Pinterest-Layout
//
//  Created by MS1 on 12/17/17.
//  Copyright © 2017 MS1. All rights reserved.
//

import UIKit

class PostCell: BaseCell{
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 5.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 3.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let timeAgoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor.gray
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    var post: Post!{
        didSet{
            updateUI()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(postImageView)
        addSubview(captionLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(timeAgoLabel)
        
        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.topAnchor.constraint(equalTo: topAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 200)
            ])
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            captionLabel.bottomAnchor.constraint(equalTo: profileImageView.topAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            profileImageView.heightAnchor.constraint(equalToConstant: 36),
            profileImageView.widthAnchor.constraint(equalToConstant: 36),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
        
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4)
            ])
        
        NSLayoutConstraint.activate([
            timeAgoLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 3),
            timeAgoLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor)
            ])
    }
    
    
    private func updateUI(){
        
        profileImageView.image = post.createdBy.profileImage
        usernameLabel.text = post.createdBy.username
        timeAgoLabel.text = post.timeAgo
        captionLabel.text = post.caption
        postImageView.image = post.image
        
    }
}


class BaseCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    class var identifier: String{
        return String(describing: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
