//
//  GroupImageTableViewCell.swift
//  Agus Cahyono
//
//  Created by Agus Cahyono on 27/04/19.
//  Copyright © 2019 Agus Cahyono. All rights reserved.
//

import UIKit

protocol GroupImageDelegate {
    func didSelectedOn(_ index: Int, image: UIImage?)
}

class GroupImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gridImage: DynamicCollectionView!
    
    class var reusableIndentifer: String { return String(describing: self) }
    
    static func reUse() -> UINib {
        return UINib(nibName: self.reusableIndentifer, bundle: Bundle.main)
    }
    
    var delegate: GroupImageDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        gridImage.dataSource = self
        gridImage.delegate = self
        
        gridImage.register(GridImageCollectionViewCell.reUse(), forCellWithReuseIdentifier: GridImageCollectionViewCell.reusableIndentifer)
        
        gridImage.backgroundColor = .clear
        gridImage.isUserInteractionEnabled = true
        gridImage.showsHorizontalScrollIndicator = false
        gridImage.showsVerticalScrollIndicator =  false
        gridImage.isScrollEnabled = false
        gridImage.clipsToBounds = true
        gridImage.contentInset = UIEdgeInsets.init(top: 0, left: 18, bottom: 0, right: 18)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}



extension GroupImageTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize / 2.26, height: 100)
        
    }
    
}

extension GroupImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colls = collectionView.dequeueReusableCell(withReuseIdentifier: GridImageCollectionViewCell.reusableIndentifer, for: indexPath) as! GridImageCollectionViewCell
        
        if indexPath.row == 0 {
            DispatchQueue.main.async {
                colls.image.roundCorners([.topRight, .bottomRight, .bottomLeft], radius: 14)
                 colls.image.layer.masksToBounds = true
            }
        } else if indexPath.row == 1 {
            DispatchQueue.main.async {
                colls.image.roundCorners([.topLeft, .bottomRight, .bottomLeft], radius: 14)
                colls.image.layer.masksToBounds = true
            }
        } else if indexPath.row == 2 {
            DispatchQueue.main.async {
                colls.image.roundCorners([.topRight, .bottomRight, .topLeft], radius: 14)
                colls.image.layer.masksToBounds = true
            }
        } else {
            DispatchQueue.main.async {
                colls.image.roundCorners([.topRight, .topLeft, .bottomLeft], radius: 14)
                colls.image.layer.masksToBounds = true
            }
        }
        
        return colls
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("KEPILIH")
        self.delegate?.didSelectedOn(indexPath.row, image: UIImage(named: "me"))
    }
    
}
