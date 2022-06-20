//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainView: MainView!
    
    // MARK: func
    fileprivate func setupView() {
        let mainView = MainView(frame: self.view.frame)
        self.mainView = mainView
        self.view.addSubview(mainView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        
        self.title = "전국 날씨"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        

    }
}
