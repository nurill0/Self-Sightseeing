//
//  MenuVC.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit

class MenuVC: BaseVC {
    
    lazy var mapBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "map"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.tag = 1
        btn.addTarget(self, action: #selector(goPages(sender: )), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var infoBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "info"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.tag = 2
        btn.addTarget(self, action: #selector(goPages(sender: )), for: .touchUpInside)
        
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuUI()
    }
    
    
}



//MARK: actions
extension MenuVC {
    
    @objc func goPages(sender: UIButton){
        var vc = UIViewController()
        switch sender.tag {
        case 1: vc = MapVC()
        case 2: vc = InfoVC()
        default: print("unknown error")
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}



//MARK: UI
extension MenuVC {
    
    fileprivate func setUpMenuUI(){
        backBtn.isHidden = true
        mapBtnConst()
        infoBtnConst()
    }
    
    
    fileprivate func mapBtnConst(){
        view.addSubview(mapBtn)
        mapBtn.left(view.leftAnchor, 10)
        mapBtn.bottom(view.centerYAnchor, -40)
        mapBtn.height(160)
        mapBtn.width(260)
    }
    
    
    fileprivate func infoBtnConst(){
        view.addSubview(infoBtn)
        infoBtn.right(view.rightAnchor, -10)
        infoBtn.top(view.centerYAnchor, 40)
        infoBtn.height(190)
        infoBtn.width(260)
    }
    
}
