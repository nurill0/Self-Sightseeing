//
//  PinVC.swift
//  Self Sightseeing
//
//  Created by Nurillo Domlajonov on 14/09/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class PinVC: BaseVC {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PinCell.self, forCellWithReuseIdentifier: PinCell.identifier)
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "deleteBtn"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(deletePin), for: .touchUpInside)
        
        return btn
    }()
    
    var imgUrls: [String] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var city = "" {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var count = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let database = Database.database().reference(fromURL: "https://self-sightseeing-69ab7-default-rtdb.firebaseio.com/")
    let uDManager = UserDefaultsManager.shared
    var emotion = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromDB()
        getImagesFromDB()
        setUpPinUI()
    }
    
}



//Fetch data from DB
extension PinVC {
    
    @objc func deletePin(){
        let alert = UIAlertController(title: "Warning", message: "Do you want delete this pin?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [self] action in
            database.child("\(uDManager.getIdForDB())").removeValue()
            dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    
    func getDataFromDB() {
        database.child("\(uDManager.getIdForDB())").observe(.value) { [self] snap, key  in
            if let dictionary = snap.value as? [String: Any] {
                self.city = dictionary["comments"] as! String
                self.emotion = dictionary["emotion"] as! String
                collectionView.reloadData()
            }
        }
    }
    
    
    func getImagesFromDB() {
        database.child("\(uDManager.getIdForDB())").child("imageUrls").observe(.value) { snap, key  in
            self.count = Int(snap.childrenCount)
            if let imageNames = snap.value {
                self.imgUrls = imageNames as! [String]
                print(self.imgUrls)
                self.collectionView.reloadData()
            }
            self.collectionView.reloadData()
        }
    }
    
}



//MARK: collectionView delegate + data source
extension PinVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinCell.identifier, for: indexPath) as! PinCell
        cell.initItems(imgUrl: imgUrls[indexPath.item], title: city, emotion: emotion)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}



//MARK: UI
extension PinVC {
    
    fileprivate func setUpPinUI(){
        deleteBtnConst()
        collectionViewConst()
    }
    
    
    fileprivate func collectionViewConst(){
        view.addSubview(collectionView)
        collectionView.top(backBtn.bottomAnchor, 20)
        collectionView.right(view.rightAnchor)
        collectionView.left(view.leftAnchor)
        collectionView.bottom(view.safeAreaLayoutGuide.bottomAnchor, -75)
    }
    
    
    fileprivate func deleteBtnConst(){
        view.addSubview(deleteBtn)
        deleteBtn.bottom(view.safeAreaLayoutGuide.bottomAnchor, -20)
        deleteBtn.centerX(view.centerXAnchor)
        deleteBtn.height(45)
        deleteBtn.width(190)
    }
    
}

