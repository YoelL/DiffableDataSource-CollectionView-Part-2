//
//  ContactCell.swift
//  DiffableDataSource CollectionView
//
//  Created by Yoel Lev on 12/08/2019.
//  Copyright © 2019 Yoel Lev. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell  {

    var contact: Contact? {
        didSet {
            nameLbl.text = contact?.name
            contactImage.loadImageUsingCacheWithUrlString(urlString: contact?.image ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCardCellShadow()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Contact Name", size: 22)
        lbl.textColor = UIColor.init(white: 0.3, alpha: 0.4)
        return lbl
    }()
    
    lazy var contactImage: UIImageView = {
        let profileImg = UIImage(systemName: "person.crop.circle")
        let renderedImg = profileImg!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imv = UIImageView(image: renderedImg )
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.layer.cornerRadius = 25
        imv.layer.masksToBounds = true
        return imv
    }()
    
    private func setupCell() {
    
        self.backgroundView?.addSubview(contactImage)
        self.backgroundView?.addSubview(nameLbl)

        NSLayoutConstraint.activate([
            contactImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contactImage.widthAnchor.constraint(equalToConstant: 50),
            contactImage.heightAnchor.constraint(equalToConstant: 50),

            nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            nameLbl.widthAnchor.constraint(equalToConstant: 200),
            nameLbl.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    override var isHighlighted: Bool {
        
        didSet{
            
            var transform = CGAffineTransform.identity
            if isHighlighted {
               transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    func setupCardCellShadow() {
         backgroundView = UIView()
         addSubview(backgroundView!)
         backgroundView?.fillSuperview()
         backgroundView?.backgroundColor     = .white
         backgroundView?.layer.cornerRadius  = 26
         backgroundView?.layer.shadowOpacity = 0.1
         backgroundView?.layer.shadowOffset  = .init(width: 4, height: 10)
         backgroundView?.layer.shadowRadius  = 10

         layer.borderColor  = UIColor.gray.cgColor
         layer.borderWidth  = 0.2
         layer.cornerRadius = 26
         self.layoutIfNeeded()
     }
    
}
