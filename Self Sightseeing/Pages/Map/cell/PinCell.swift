//
//  PinCell.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit

class PinCell: UICollectionViewCell {
    
    static let identifier = "pincell"
    lazy var containerV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var imgFrame: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "imgFrame")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var locagtionImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "location")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var emotionImgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "emotion")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var informationLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "In their quest to improve quality of life, they forget that implementing modern techniques creates the need to incorporate the whole into the production plan."
        lbl.textColor = .titleColors()
        lbl.font = UIFont(name: "Montserrat-Bold", size: 18)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        
        return lbl
    }()
    
    var imgurl = ""
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCellUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initItems(imgUrl: String, title: String, emotion: String){
        informationLbl.text = title
        emotionImgView.image = UIImage(named: emotion)
        imgView.setImageFrom(imgUrl)
    }
    
}



extension PinCell {
    
    fileprivate func setUpCellUI(){
        containerVConst()
        imgFrameConst()
        imgViewConst()
        locationImgConst()
        emotionImgConst()
        informationLblConst()
    }
    
    
    fileprivate func containerVConst(){
        self.addSubview(containerV)
        containerV.top(self.topAnchor, 10)
        containerV.bottom(self.bottomAnchor, -10)
        containerV.right(self.rightAnchor, -10)
        containerV.left(self.leftAnchor, 10)
    }
    
    
    fileprivate func imgFrameConst(){
        containerV.addSubview(imgFrame)
        imgFrame.top(containerV.topAnchor, 30)
        imgFrame.right(containerV.rightAnchor, -20)
        imgFrame.left(containerV.leftAnchor, 20)
        imgFrame.height(200)
    }
    
    
    fileprivate func imgViewConst(){
        containerV.addSubview(imgView)
        imgView.centerY(imgFrame.centerYAnchor)
        imgView.right(imgFrame.rightAnchor, -30)
        imgView.left(imgFrame.leftAnchor, 30)
        imgView.height(180)
    }
    
    
    fileprivate func locationImgConst(){
        containerV.addSubview(locagtionImgView)
        locagtionImgView.top(imgFrame.bottomAnchor)
        locagtionImgView.right(containerV.centerXAnchor, -20)
        locagtionImgView.height(80)
        locagtionImgView.width(80)
    }
    
    
    fileprivate func emotionImgConst(){
        containerV.addSubview(emotionImgView)
        emotionImgView.centerY(locagtionImgView.centerYAnchor)
        emotionImgView.left(containerV.centerXAnchor, 20)
        emotionImgView.height(50)
        emotionImgView.width(50)
    }
    
    
    fileprivate func informationLblConst(){
        containerV.addSubview(informationLbl)
        informationLbl.top(emotionImgView.bottomAnchor, 20)
        informationLbl.left(imgFrame.leftAnchor)
        informationLbl.right(imgFrame.rightAnchor)
    }
    
}
