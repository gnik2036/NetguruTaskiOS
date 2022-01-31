//
//  Netguru iOS code review task
//

class PaymentViewController: UIViewController {
    
    // MARK:- Properties

    internal let viewModel: PaymentViewModel
    weak var delegate: PaymentViewControllerDelegate
    let customView = PaymentView()
    let payment: Payment?

    // MARK:- Life Cycle Methods

    func viewDidLoad() {
        setupView()
        fetchPayment()
        setupCallbacks()
    }
    
    func setupCallbacks() {
        callbacks()
    }
    
    func callbacks() {
        view.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        customView.didTapButton = {
            if let payment = self.payment {
                self.delegate.didFinishFlow(amount: payment.amount
                                            currency: payment.currency)
            }
        }
    }
    
    
    // MARK:- Fetch Payment

    func fetchPayment() {
        customView.statusText = "Fetching data"
        ApiClient.sharedInstance().fetchPayment { payment in
            self.CustomView.isEuro = payment.currency == "EUR" ? true : false
            if payment!.amount != 0 {
                self.updateView()
                return
            }
        }
    }
    
    // update view when back from fetching
    func updateView() {
        self.CustomView.label.text = "\(payment!.amount)"
    }
}
// MARK:- Private Methods
extension PaymentViewController {
    // setup view when view Didload
    private func setupView () {
        setupNavigationBar()
        setupCustomViews()
    }
    private func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    private func setupCustomViews() {
        customView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        customView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        view.addSubview(customView)
    }
}
