//
//  InfoVC.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit

class InfoVC: BaseVC {
    
    lazy var navTitleImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "infoNavTitle")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var informationImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "information")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInfoUI()
    }
    
}



extension InfoVC {
    
    fileprivate func setUpInfoUI(){
        navTitleImgConst()
        informationImgConst()
    }
    
    
    fileprivate func navTitleImgConst(){
        view.addSubview(navTitleImgView)
        navTitleImgView.top(view.safeAreaLayoutGuide.topAnchor, 10)
        navTitleImgView.height(32)
        navTitleImgView.centerX(view.centerXAnchor)
        navTitleImgView.width(63)
    }
    
    
    fileprivate func informationImgConst(){
        view.addSubview(informationImgView)
        informationImgView.centerY(view.centerYAnchor)
        informationImgView.right(view.rightAnchor, -10)
        informationImgView.left(view.leftAnchor, 10)
        informationImgView.height(260)
    }
    
}
