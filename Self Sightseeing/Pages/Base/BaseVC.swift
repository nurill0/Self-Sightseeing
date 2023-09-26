//
//  ViewController.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit

class BaseVC: UIViewController {
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "backBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var bgImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "bg")
        img.contentMode = .scaleAspectFill
        
        return img
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseUI()
    }
    
    
    @objc func goBack(){
        dismiss(animated: true)
    }

}




extension BaseVC {
    
    fileprivate func configureBaseUI(){
        bgImgViewConst()
        backBtnConst()
    }
    
    fileprivate func bgImgViewConst(){
        view.addSubview(bgImage)
        bgImage.top(view.topAnchor)
        bgImage.bottom(view.bottomAnchor)
        bgImage.right(view.rightAnchor)
        bgImage.left(view.leftAnchor)
    }
    
    
    fileprivate func backBtnConst(){
        view.addSubview(backBtn)
        backBtn.top(view.safeAreaLayoutGuide.topAnchor, 10)
        backBtn.left(view.leftAnchor, 20)
        backBtn.height(50)
        backBtn.width(100)
    }
}
