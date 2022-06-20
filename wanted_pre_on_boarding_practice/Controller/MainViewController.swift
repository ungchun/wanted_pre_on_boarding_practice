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
        view.backgroundColor = .black
        
        setupView()
        
        self.title = "전국 날씨"
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
      
    }
    

}
