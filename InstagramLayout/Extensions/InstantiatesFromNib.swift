//
//  InstantiatesFromNib.swift
//  InstagramLayout
//
//  Created by Andrea Stevanato on 28/01/21.
//

import UIKit

protocol InstantiatesFromNib: class {
    func setupView()
}

extension InstantiatesFromNib where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }

    static func instanceFromNib() -> Self {
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! Self
        view.setupView()
        return view
    }

    func setupView() {
    }
}

