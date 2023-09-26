//
//  AddPinItem.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import Foundation
import UIKit

class AddPinItem: UIView {
    var itemCount = 0
    
    lazy var frameImg: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.image = UIImage(named: "emptyImg")
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        return img
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "deleteBtnItem"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(deleteimg), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    convenience init(itemCount: Int) {
        self.init(frame: .zero)
        self.itemCount = itemCount
    }
    
    @objc func deleteimg(){
        itemCount-=1
        imgView.image = UIImage(named: "emptyImg")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension AddPinItem {
    
    fileprivate func setUpUI(){
        frameImgConst()
        imgViewConst()
        deleteBtnConst()
    }
    
    fileprivate func frameImgConst(){
        self.addSubview(frameImg)
        frameImg.top(self.topAnchor, 5)
        frameImg.centerX(self.centerXAnchor)
        frameImg.height(60)
        frameImg.width(60)
    }
    
    fileprivate func imgViewConst(){
        self.addSubview(imgView)
        imgView.centerY(frameImg.centerYAnchor)
        imgView.centerX(frameImg.centerXAnchor)
        imgView.height(50)
        imgView.width(50)
    }
    
    fileprivate func deleteBtnConst(){
        self.addSubview(deleteBtn)
        deleteBtn.top(frameImg.bottomAnchor)
        deleteBtn.centerX(self.centerXAnchor)
        deleteBtn.width(35)
        deleteBtn.height(35)
    }
}
