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
    weak var delegate: PaymentViewDelegate?
    
    
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
        dismissButton.isHidden = true;
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
        dismissButton.isHidden = false;
    }
    
    func displayPaymentErrorView(message: String) {
        paymentErrorView.isHidden = false;
    }
    
    
    // MARK: - IBAction
    
    @IBAction func dismissView(_ sender: Any) {
        router.dismiss() { [weak self] in
            // Notify delegate the payment has finished.
            self?.delegate?.didCompletePayment();
        }
    }

}
