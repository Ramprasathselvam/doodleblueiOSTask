//
//  ViewController.swift
//  doodleblueiOSTask
//
//  Created by Ramprasath Selvam on 06/09/20.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Outlets
    @IBOutlet var collectionView:UICollectionView!
    
    //MARK: - Cell Identifiers
    let collectionViewCellId = "collectionViewCell"
    let collectionViewHeaderId = "CollectionReusableView"
    
    //MARK: - Variables
    var isHeaderCollapse:Bool = false
    var isMultiSelection:Bool = false
    var laseSelectedSell:Int?

    private var viewModel = [CollectionListViewModel]()
    
    //Refresh Controll
    var refreshView = UIRefreshControl()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // CollectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Set up methods
        self.getData()
        self.setupLongGestureRecognizerOnCollectionView()
        
        //Refresh View
        refreshView = UIRefreshControl()
        refreshView.addTarget(self, action: #selector(updateCollectionList), for: .valueChanged)
        refreshView.tintColor = UIColor.darkGray
        refreshView.attributedTitle = NSAttributedString(string: "Updating..", attributes: nil)
        self.collectionView.addSubview(refreshView)
    }

    override func viewWillLayoutSubviews() {
        collectionView.reloadData()
    }
    
    // Get Data
    fileprivate func getData(){
        let data = CommonHelper().fetchData()
        do {
            let collectionListModel = try JSONDecoder().decode([CollectionListModel].self, from: data)
            self.viewModel = collectionListModel.map({CollectionListViewModel(collectionListModel:$0)})
            self.collectionView.reloadData()
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        } catch {
            print("Failed to Fetch Data")
        }
    }
    
    // Multi Selection Long Press Gesture
    private func setupLongGestureRecognizerOnCollectionView() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        let position = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView?.indexPathForItem(at: position) {
            self.isMultiSelection = true
            viewModel[indexPath.row].isSelected = !viewModel[indexPath.row].isSelected
            self.collectionView.reloadData()
        }
    }
    
    //Refresh View
    @objc func updateCollectionList(){
        //TODO: - Change in Feature
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.getData()
            self.collectionView.reloadData()
            self.refreshView.endRefreshing()
        })
    }
    
    //MARK: - Button Actions
    // collapse & Expand Collection views
    @IBAction func collapseButton(){
        self.isHeaderCollapse = !self.isHeaderCollapse
        self.collectionView.reloadData()
    }

    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isHeaderCollapse{
            return 0
        }
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! CollectionViewCell
        let vm = viewModel[indexPath.row]
        cell.viewModel = vm
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderId, for: indexPath) as! CollectionReusableView
            headerView.headerLabel.text = "Collection Header"
            return headerView
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        viewModel[row].isSelected = !(viewModel[row].isSelected)
        if isMultiSelection {
            //Multiple Selection
            collectionView.reloadData()
            for item in viewModel{
                if item.isSelected{
                    return
                }
            }
            self.isMultiSelection = false
        }else{
            //Single Selection
            if viewModel[row].isSelected{
                self.collapseButton()
            }
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.size.width / 2) - 40
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}

