//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

//private var sceneView: SKView?
//private var snowScene: SnowScene?

//lazy var snowView: SKView = {
//    let view = SKView()
//    view.backgroundColor = .clear
//    let scene = SnowScene()
//    view.presentScene(scene)
//    return view
//}()

//        view.addSubview(snowView)
//        snowView.translatesAutoresizingMaskIntoConstraints = false
//        snowView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        snowView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        snowView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        snowView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

class MainViewController: UIViewController  {
    
    var sendWeatherModelDelegate: SendWeatherModelDelegate?
    
    private var mainView: MainView!
    
    // Main 에서는 navigationBar Title 이 large 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupView()
        setNavigationBarTitle()
        
    }
    
    // MARK: func
    fileprivate func setupView() {
        let mainView = MainView(frame: self.view.frame)
        self.mainView = mainView
        mainView.cellTapAction = navigationDetailView(_:)
        self.view.addSubview(mainView)
    }
    
    fileprivate func setNavigationBarTitle() {
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
    
    fileprivate func navigationDetailView(_ weatherModel: WeatherModel) {
        let detailVC = DetailViewController()
        detailVC.sendModel(weatherModel: weatherModel) // 델리게이트로 도시정보 전달
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

