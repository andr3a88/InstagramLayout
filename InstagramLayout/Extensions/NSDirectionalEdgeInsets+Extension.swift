//
//  NSDirectionalEdgeInsets+Extension.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 28/01/21.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func uniform(size: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
    }

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
