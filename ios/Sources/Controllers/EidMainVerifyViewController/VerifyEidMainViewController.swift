//
//  VerifyEidMainViewController.swift
//  xverifydemoapp
//
//  Created by Minh Tri on 23/12/2023.
//

import UIKit

class VerifyEidMainViewController: NavigationBarViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introDescription: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoImage(UIImage(named: "ic_header_logo"))
    }


    // --------------------------------------
    // MARK: Overried
    // --------------------------------------
    override func setupUI() {
        titleLabel.text = LOCALIZED("intro_title_eid")
        introDescription.text = LOCALIZED("intro_description_eid")
        startButton.layer.cornerRadius = self.startButton.frame.height / 2
    }
    
    override var leftBarButton: UIButton? {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "ic_action_arrowback"), for: .normal)
        button.tintColor = .white
        return button
    }
    
    override func handleLeftBarButtonEvent() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    // --------------------------------------
    // MARK: Event
    // --------------------------------------
    @IBAction func startButtonAction(_ sender: UIButton) {
        let controller = INIT_CONTROLLER_XIB(MRZScannerViewController.self)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
