
import UIKit

let cellId = "Cell"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10

        let gridButton = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        gridButton.backgroundColor = .systemBlue
        gridButton.setTitle("show Grid collection", for: .normal)
        gridButton.addTarget(self, action: #selector(didGridTapButton), for: .touchUpInside)

        let listButton = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 50))
        listButton.backgroundColor = .systemBlue
        listButton.setTitle("show List collection", for: .normal)
        listButton.addTarget(self, action: #selector(didListTapButton), for: .touchUpInside)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(gridButton)
        stackView.addArrangedSubview(listButton)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func didGridTapButton() {
        // layout 만들기
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 3)-3, height: (view.frame.width / 3)-3)
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumInteritemSpacing = 1

        // Collection VC
        let vc = GridCollectionViewController(collectionViewLayout: layout)
        vc.title = "Grid Controller"
        vc.navigationItem.largeTitleDisplayMode = .always

        // Navigation VC
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationBar.prefersLargeTitles = true

        // Presenting VC
        present(navVC, animated: true)
    }

    @objc func didListTapButton() {
        // layout 만들기
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width)-30, height: (view.frame.width / 3))
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 1

        // Collection VC
        let vc = ListCollectionViewController(collectionViewLayout: layout)
        vc.title = "List Controller"
        vc.navigationItem.largeTitleDisplayMode = .always

        // Navigation VC
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationBar.prefersLargeTitles = true

        // Presenting VC
        present(navVC, animated: true)
    }
}

