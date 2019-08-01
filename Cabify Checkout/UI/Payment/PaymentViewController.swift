//
//  PaymentViewController.swift
//  Cabify Checkout
//
//  Display the Payment screen
//

import UIKit

class PaymentViewController: BaseViewController, PaymentViewContract {
    
    
    // MARK: - Properties
    var presenter: PaymentPresenterContract!
    var router: PaymentRouterContract!
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var processingView: UIView!
    @IBOutlet weak var paymentSuccessView: PaymentSuccessView!
    @IBOutlet weak var paymentErrorView: UIView!
    @IBOutlet weak var dismissButton: UIButton!

    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        configureViews();
        
        presenter.onViewCreated();
    }
    
    private func configureViews() {
        processingView.isHidden = true;
        paymentSuccessView.isHidden = true;
        paymentErrorView.isHidden = true;
    }
    
    
    
    // MARK: - PaymentViewContract
    
    func displayProcessingPaymentView() {
        processingView.isHidden = false;
    }
    
    func hideProcessingPaymentView() {
        processingView.isHidden = true;
    }
    
    func displayPaymentSuccessView() {
        paymentSuccessView.isHidden = false;
        paymentSuccessView.startAnimation();
    }
    
    func displayPaymentErrorView(message: String) {
        paymentErrorView.isHidden = false;
    }
    
    
    // MARK: - IBAction
    
    func dismissView(_ sender: Any) {
        router.dismiss();
    }

}
