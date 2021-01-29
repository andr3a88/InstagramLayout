//
//  ProfileHeaderCell.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 27/01/21.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {

    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var accountTypeLabel: UILabel!

    @IBOutlet var numberOfPostsLabel: UILabel!

    func configure(with data: ProfileHeaderData) {
        nameLabel.text = data.name
        accountTypeLabel.text = data.accountType
        numberOfPostsLabel.text = String(data.postCount)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height/2
    }

}
