//
//  PhotoSelectorController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/29/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage]()
    var selectedImage:UIImage?
    var assets = [PHAsset]()
    var headert:PhotoSelectorHeader?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        setupNavButtons()
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.register(PhotoSelectorHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        
        fetchPhoto()
        
    }
    
    func  assetsFetchOptions() -> PHFetchOptions{
        let options = PHFetchOptions()
        options.fetchLimit = 40
        let Desc = NSSortDescriptor(key: "creationDate", ascending: false)
        options.sortDescriptors = [Desc]
        return options
    }
    func fetchPhoto(){
        
        let allPics = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        DispatchQueue.global(qos: .background).async {
            allPics.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let target = CGSize(width: 200, height: 200)
                let opt = PHImageRequestOptions()
                opt.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: target, contentMode: .aspectFit, options: opt) { (image, info) in
                    
                    guard let image = image else {return}
                    self.images.append(image)
                    self.assets.append(asset)
                    
                    if count == self.images.count - 1 {
                        self.selectedImage = self.images[0]
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header  = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! PhotoSelectorHeader
        
        if let selectedIMG = selectedImage{
            self.headert = header
            header.headerImageView.image = selectedIMG
            if let index = self.images.firstIndex(of: selectedIMG){
                
                let selectedAsset = self.assets[index]
                let imageManager = PHImageManager.default()
                let target = CGSize(width: 1000, height: 1000)
                imageManager.requestImage(for: selectedAsset, targetSize: target, contentMode: .default, options: nil) { (image, info) in
                    
                    header.headerImageView.image = image
                }
            }
            
        }
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PhotoCell
        
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = images[indexPath.item]
        self.collectionView.reloadData()
        let index = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: index, at: .bottom, animated: true)
    }
    override var prefersStatusBarHidden: Bool {
        true
    }
    func setupNavButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    @objc func handleCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    @objc func handleNext() {
           
           // code here to handle nnext button.
        let viewController = SharePhotoController()
        viewController.selectedImage = headert?.headerImageView.image
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
}
