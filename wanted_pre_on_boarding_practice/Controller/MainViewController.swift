//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

// MARK: SpriteKit
import SpriteKit

class SnowScene: SKScene {

    override func didMove(to view: SKView) {
        setScene(view)
        setSnowNode()
    }

    override func didApplyConstraints() {
        guard let view = view else { return }
        scene?.size = view.frame.size
    }

    private func setScene(_ view: SKView) {
        backgroundColor = .clear
        scene?.anchorPoint = CGPoint(x: 0.5, y: 1)
        scene?.scaleMode = .aspectFill
    }

    private func setSnowNode() {
        guard let snowNode = SKEmitterNode(fileNamed: "snow") else { return }
        snowNode.position = .zero
        scene?.addChild(snowNode)
    }
}

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


class MainViewController: UIViewController {
    
    private var mainView: MainView!
    
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
    
    // MARK: func
    fileprivate func setupView() {
        let mainView = MainView(frame: self.view.frame)
        self.mainView = mainView
        self.view.addSubview(mainView)
    }
}
