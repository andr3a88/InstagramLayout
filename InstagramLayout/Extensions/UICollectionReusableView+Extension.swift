//
//  UICollectionReusableView+Extension.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 27/01/21.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
