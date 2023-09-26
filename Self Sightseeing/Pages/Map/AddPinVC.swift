//
//  AddPinVC.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit
import FirebaseStorage

class AddPinVC: BaseVC, UINavigationControllerDelegate {
    
    var count = 0
    let dbManager = DatabaseManager.shared
    private let storage = Storage.storage().reference()
    
    lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "saveBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(saveItems), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "addImgView")
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addImg))
        img.addGestureRecognizer(gesture)
        
        return img
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    lazy var firstItem: AddPinItem = {
        let item = AddPinItem(itemCount: count)
        item.itemCount = count
        
        return item
    }()
    
    lazy var secondItem: AddPinItem = {
        let item = AddPinItem(itemCount: count)
        item.itemCount = count
        
        return item
    }()
    
    lazy var thirdItem: AddPinItem = {
        let item = AddPinItem(itemCount: count)
        item.itemCount = count
        
        return item
    }()
    
    lazy var fourthItem: AddPinItem = {
        let item = AddPinItem(itemCount: count)
        
        return item
    }()
    
    lazy var fivesItem: AddPinItem = {
        let item = AddPinItem(itemCount: count)
        item.itemCount = count
        item.itemCount = count
        
        return item
    }()
    
    lazy var sadEmotionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 1
        btn.setImage(UIImage(named: "1"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(getEmotion(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var unhappyEmotionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 2
        btn.setImage(UIImage(named: "2"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(getEmotion(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var neytralEmotionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 3
        btn.setImage(UIImage(named: "3"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(getEmotion(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var happyEmotionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 4
        btn.setImage(UIImage(named: "4"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(getEmotion(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var veryHappyEmotionBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 5
        btn.setImage(UIImage(named: "5"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(getEmotion(sender:)), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var emotionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    lazy var emotionFrameView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "emotionFrame")
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var textViewFrame: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.textColor = .titleColors()
        txtView.textAlignment = .left
        txtView.font = UIFont(name: "Montserrat-Bold", size: 16)
        txtView.showsVerticalScrollIndicator = false
        txtView.layer.shadowColor = UIColor.black.cgColor
        txtView.layer.shadowOffset = CGSize(width: 0, height: 0)
        txtView.layer.shadowRadius = 3
        txtView.layer.shadowOpacity = 2
        txtView.clipsToBounds = false
        txtView.layer.cornerRadius = 14
        txtView.backgroundColor = .white
        
        return txtView
    }()
    
    var id = Int.random(in: 1...1000)
    var latForDB = 0.0
    var longForDB = 0.0
    var emotionForDb = ""
    let uDManager = UserDefaultsManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAddPinUI()
    }
    
    
}


extension AddPinVC {
    
    @objc func getEmotion(sender: UIButton){
        if sender.tag == 1 {
            sadEmotionBtn.setImage(UIImage(named:"selected\(sender.tag)" ), for: .normal)
            unhappyEmotionBtn.setImage(UIImage(named: "2"), for: .normal)
            neytralEmotionBtn.setImage(UIImage(named: "3"), for: .normal)
            happyEmotionBtn.setImage(UIImage(named: "4"), for: .normal)
            veryHappyEmotionBtn.setImage(UIImage(named: "5"), for: .normal)
            emotionForDb = "selected\(sender.tag)"
        }else if sender.tag == 2 {
            unhappyEmotionBtn.setImage(UIImage(named:"selected\(sender.tag)" ), for: .normal)
            sadEmotionBtn.setImage(UIImage(named: "1"), for: .normal)
            neytralEmotionBtn.setImage(UIImage(named: "3"), for: .normal)
            happyEmotionBtn.setImage(UIImage(named: "4"), for: .normal)
            veryHappyEmotionBtn.setImage(UIImage(named: "5"), for: .normal)
            emotionForDb = "selected\(sender.tag)"
        }else if sender.tag == 3 {
            neytralEmotionBtn.setImage(UIImage(named:"selected\(sender.tag)" ), for: .normal)
            sadEmotionBtn.setImage(UIImage(named: "1"), for: .normal)
            unhappyEmotionBtn.setImage(UIImage(named: "2"), for: .normal)
            happyEmotionBtn.setImage(UIImage(named: "4"), for: .normal)
            veryHappyEmotionBtn.setImage(UIImage(named: "5"), for: .normal)
            emotionForDb = "selected\(sender.tag)"
        }else if sender.tag == 4 {
            happyEmotionBtn.setImage(UIImage(named:"selected\(sender.tag)" ), for: .normal)
            sadEmotionBtn.setImage(UIImage(named: "1"), for: .normal)
            neytralEmotionBtn.setImage(UIImage(named: "3"), for: .normal)
            unhappyEmotionBtn.setImage(UIImage(named: "2"), for: .normal)
            veryHappyEmotionBtn.setImage(UIImage(named: "5"), for: .normal)
            emotionForDb = "selected\(sender.tag)"
        }else if sender.tag == 5 {
            veryHappyEmotionBtn.setImage(UIImage(named:"selected\(sender.tag)" ), for: .normal)
            sadEmotionBtn.setImage(UIImage(named: "1"), for: .normal)
            neytralEmotionBtn.setImage(UIImage(named: "3"), for: .normal)
            happyEmotionBtn.setImage(UIImage(named: "4"), for: .normal)
            unhappyEmotionBtn.setImage(UIImage(named: "2"), for: .normal)
            emotionForDb = "selected\(sender.tag)"
        }
    }
    
    
    @objc func addImg(){
        showChooseAlert()
        print("open img")
    }
    
    
    @objc func saveItems(){
        let db = DatabaseManager.shared
        if textViewFrame.text.isEmpty == false {
            for i in 0...count {
                switch i {
                case 1: db.addImg(userName: "\(id)-\(i)", imgData: firstItem.imgView.image!,desc: textViewFrame.text, emotion: emotionForDb, lat: latForDB, long: longForDB)
                case 2: db.addImg(userName:"\(id)-\(i)", imgData: secondItem.imgView.image!,desc: textViewFrame.text,emotion: emotionForDb, lat: latForDB, long: longForDB)
                case 3: db.addImg(userName:"\(id)-\(i)", imgData: thirdItem.imgView.image!,desc: textViewFrame.text,emotion: emotionForDb, lat: latForDB, long: longForDB)
                case 4: db.addImg(userName:"\(id)-\(i)", imgData: fourthItem.imgView.image!,desc: textViewFrame.text,emotion: emotionForDb, lat: latForDB, long: longForDB)
                case 5: db.addImg(userName:"\(id)-\(i)", imgData: fivesItem.imgView.image!,desc: textViewFrame.text,emotion: emotionForDb, lat: latForDB, long: longForDB)
                case 6: db.addImg(userName:"\(id)-\(i)", imgData: imgView.image!,desc: textViewFrame.text,emotion: emotionForDb, lat: latForDB, long: longForDB)
                    count = 0
                default: print("nothing saved")
                }
            }
            var cc = uDManager.getDataCount()
            cc+=1
            uDManager.setDataCount(count: cc)
            showSavedAlert()
        }else {
            showErrorAlert()
        }
    }
    
    
    func showSavedAlert(){
        let alert = UIAlertController(title: "Saved", message: "Your datas successful saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please enter all data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func showChooseAlert(){
        let alert = UIAlertController(title: "Choose Photos", message: "You can choose photos from library or take a photo", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose from library", style: .default, handler: { [self] alert in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Take a picture", style: .default, handler: { [self] alert in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
            
        }))
        present(alert, animated: true)
    }
}



extension AddPinVC {
    
    fileprivate func setUpAddPinUI(){
        imgViewConst()
        saveBtnConst()
        stackViewConst()
        emotionFrameConst()
        emotionStackConst()
        textViewFrameConst()
    }
    
    
    fileprivate func saveBtnConst(){
        view.addSubview(saveBtn)
        saveBtn.bottom(view.safeAreaLayoutGuide.bottomAnchor, -20)
        saveBtn.centerX(view.centerXAnchor)
        saveBtn.height(45)
        saveBtn.width(190)
    }
    
    
    fileprivate func imgViewConst(){
        view.addSubview(imgView)
        if view.frame.height < 670{
            imgView.top(backBtn.bottomAnchor, 20)
            imgView.height(180)
        }else{
            imgView.top(backBtn.bottomAnchor, 80)
            imgView.height(200)
        }
        imgView.right(view.rightAnchor, -20)
        imgView.left(view.leftAnchor, 20)
        
    }
    
    
    fileprivate func stackViewConst(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstItem)
        stackView.addArrangedSubview(secondItem)
        stackView.addArrangedSubview(thirdItem)
        stackView.addArrangedSubview(fourthItem)
        stackView.addArrangedSubview(fivesItem)
        stackView.right(imgView.rightAnchor, -20)
        stackView.left(imgView.leftAnchor, 20)
        stackView.top(imgView.bottomAnchor, 10)
        stackView.height(90)
    }
    
    
    fileprivate func emotionFrameConst(){
        view.addSubview(emotionFrameView)
        emotionFrameView.top(stackView.bottomAnchor, 20)
        emotionFrameView.right(imgView.rightAnchor)
        emotionFrameView.left(imgView.leftAnchor)
        emotionFrameView.height(70)
    }
    
    
    fileprivate func emotionStackConst(){
        view.addSubview(emotionStackView)
        emotionStackView.addArrangedSubview(sadEmotionBtn)
        emotionStackView.addArrangedSubview(unhappyEmotionBtn)
        emotionStackView.addArrangedSubview(neytralEmotionBtn)
        emotionStackView.addArrangedSubview(happyEmotionBtn)
        emotionStackView.addArrangedSubview(veryHappyEmotionBtn)
        emotionStackView.centerY(emotionFrameView.centerYAnchor)
        emotionStackView.right(emotionFrameView.rightAnchor, -20)
        emotionStackView.left(emotionFrameView.leftAnchor, 20)
        emotionStackView.height(50)
    }
    
    
    fileprivate func textViewFrameConst(){
        view.addSubview(textViewFrame)
        textViewFrame.top(emotionFrameView.bottomAnchor, 10)
        textViewFrame.bottom(saveBtn.topAnchor, -10)
        textViewFrame.right(emotionStackView.rightAnchor)
        textViewFrame.left(emotionStackView.leftAnchor)
    }
    
}



extension AddPinVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        count+=1
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        guard let imageData = image.pngData() else {
            return
        }
        
        switch count {
        case 1: firstItem.imgView.image = image
        case 2: secondItem.imgView.image = image
        case 3: thirdItem.imgView.image = image
        case 4: fourthItem.imgView.image = image
        case 5: fivesItem.imgView.image = image
        case 6: imgView.image = image
            count = 0
        default: firstItem.imgView.image = image
        }
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true )
    }
    
    
}
