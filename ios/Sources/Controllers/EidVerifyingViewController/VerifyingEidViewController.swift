//
//  VerifyingEidViewController.swift
//  xverifydemoapp
//
//  Created by Minh Tri on 24/12/2023.
//

import UIKit
import Lottie

class VerifyingEidViewController: NavigationBarViewController {

    public var completion: RCTResponseSenderBlock?
    @IBOutlet weak var animationLoading: LottieAnimationView!
    @IBOutlet weak var stepInstructionLabel: UILabel!
    
    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogoImage(UIImage(named: "ic_header_logo"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestVerifyEid()
    }
    
    // --------------------------------------
    // MARK: Overried
    // --------------------------------------
    
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
    // MARK: Services
    // --------------------------------------
    
    private func requestVerifyEid() {
        animationLoading.isHidden = false
        animationLoading.loopMode = .loop
        animationLoading.play()
        stepInstructionLabel.text = LOCALIZED("please_wait_verifying").uppercased()
        if let eid = ONBOARDDATAMANAGER.eid {
            EIDFACADE.verifyEid(eid: eid) { eidVerify in
                DispatchQueue.main.async {
                    self.animationLoading.stop()
                    let eidVerified = eidVerify.isValidIdCard
                    let publicKeyUrl = Bundle(identifier: "org.cocoapods.react-native-eid-sdk")?.url(forResource: "public", withExtension: "pem") ?? URL(fileURLWithPath: "")
                    let eidSignatureVerified = EIDFACADE.verifyRsaSignature(publicKeyUrl: publicKeyUrl, plainText: eidVerify.responds ?? "", signature: eidVerify.signature)
                    ONBOARDDATAMANAGER.eid?.eidVerified = eidVerified
                    ONBOARDDATAMANAGER.eid?.eidSignatureVerified = eidSignatureVerified
                    if eidVerified {
                        if(self.completion != nil){
                            let eidData = ONBOARDDATAMANAGER.eid
                            let data = ["personOptionalDetails":[
                                "age": "",
                                "dateOfBirth": eidData?.dg13?.dateOfBirth,
                                "dateOfExpiry": eidData?.dg13?.dateOfExpiry,
                                "dateOfIssue":  eidData?.dg13?.dateOfIssue,
                                "eidNumber": eidData?.dg13?.eidNumber,
                                "ethnicity": eidData?.dg13?.ethnicity,
                                "face": eidData?.eidImage?.toBase64(),
                                "fatherName": eidData?.dg13?.fatherName,
                                "fullname": eidData?.dg13?.fullName,
                                "gender": eidData?.dg13?.gender,
                                "motherName": eidData?.dg13?.motherName,
                                "oldEidNumber": eidData?.dg13?.oldEidNumber,
                                "personalIdentification": eidData?.dg13?.personalIdentification,
                                "placeOfOrigin": eidData?.dg13?.placeOfOrigin,
                                "placeOfResidence": eidData?.dg13?.placeOfResidence,
                                "religion": eidData?.dg13?.religion,
                                "spouseName": eidData?.dg13?.spouseName
                            ]]
                            
                            print(data)
                            self.completion!([data])
                        }
                        self.navigationController?.dismiss(animated: true)
//                        let controller = INIT_CONTROLLER_XIB(VerifyEidSuccessViewController.self)
//                        self.navigationController?.pushViewController(controller, animated: true)
                    } else {
                        Graphics.showAlert(title: LOCALIZED("verify_fail"), message: LOCALIZED("error_verification"), cancelTitle: LOCALIZED("cancel")) {
                            if let navigationController = self.navigationController {
                                navigationController.popViewController(animated: true)
                            }
                        }
                    }
                }
            } errorHandler: { error in
                self.animationLoading.stop()
                Graphics.showAlert(title: LOCALIZED("verify_fail"), message: LOCALIZED("error_verification"), cancelTitle: LOCALIZED("cancel")) {
                    if let navigationController = self.navigationController {
                        navigationController.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
