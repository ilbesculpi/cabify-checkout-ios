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
    @IBOutlet weak var operationSuccessView: UIView!
    @IBOutlet weak var operationErrorView: UIView!

    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        configureViews();
        
        presenter.onViewCreated();
    }
    
    private func configureViews() {
        processingView.isHidden = true;
        operationSuccessView.isHidden = true;
        operationErrorView.isHidden = true;
    }
    
    
    
    // MARK: - PaymentViewContract
    
    func displayProcessingPaymentView() {
        processingView.isHidden = false;
    }
    
    func hideProcessingPaymentView() {
        processingView.isHidden = true;
    }
    
    func displayOperationSuccessView() {
        operationSuccessView.isHidden = false;
    }
    
    func displayOperationErrorView() {
        operationErrorView.isHidden = false;
    }

}
