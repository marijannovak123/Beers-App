import UIKit
import RxSwift
import MBProgressHUD

class BaseViewController<V: BaseViewModel<M>, M: Persistable>: UIViewController {
    
    let viewModel: V
    
    let disposeBag = DisposeBag()
    
    private var progress: MBProgressHUD?
    
    required init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    //override if additional binds needed
    func bindToViewModel() {
        viewModel.stateRelay
            .subscribe { [unowned self] in
                self.handleState($0.element!)
            }.disposed(by: disposeBag)
    }
    
    func handleState(_ state: ViewState) {
        handleLoading(state)
    
        switch state {
        case .error(let message):
            showMessage(message)
        case .info(let message):
            showMessage(message, isError: false)
        case .content:
            onDataRefreshed(data: viewModel.data)
        case .navigate(let screen):
            self.navigate(to: screen)
        case .customEvent(let event):
            handleEvent(event)
        default: break
        }
    }
    
    //override to work with data
    func onDataRefreshed(data: M?) {
        print("Data refreshed: \(data)")
    }
    
    //override for special VC related cases
    func handleEvent(_ event: Event) {
        
    }
    
    func handleLoading(_ state: ViewState) {
        switch state {
        case .loading:
            showLoading(true)
        default:
            showLoading(false)
        }
    }
    
    func showLoading(_ show: Bool) {
        self.view.isUserInteractionEnabled = !show
        hideProgressIfAlreadyShown()
        
        if show {
            progress = MBProgressHUD.showAdded(to: self.view, animated: true)
            progress!.mode = .indeterminate
            progress!.removeFromSuperViewOnHide = true
        }
    }
    
    func hideProgressIfAlreadyShown() {
        if progress != nil {
            progress?.hide(animated: true)
            progress = nil
        }
    }
    
    func showMessage(_ message: String, isError: Bool = true) {
        if isError {
            DialogHelper.errorDialog(from: self, message: message)
        } else {
            DialogHelper.infoDialog(from: self, title: "Info", message: message)
        }
    }
    
}
