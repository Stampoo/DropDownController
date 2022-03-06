//
//  DropDownController.swift
//  
//
//  Created by Князьков Илья on 05.03.2022.
//

import UIKit

open class DropDownController: DropDownControllerProtocol {
    
    // MARK: - Nested types
   
    public typealias Adapter = DropDownTableAdapter
    
    // MARK: - Public properties
    
    public var dropDownAdapter: DropDownTableAdapter
    public var containerView: UIView
    public var animationDuration: TimeInterval = 0.3
    
    // MARK: - Private properties
    
    private var isHideAnimtaionInProcess: Bool = false
    private var isShowAnimationInProcess: Bool = false
    private var isAnimationInProgress: Bool {
        isHideAnimtaionInProcess || isShowAnimationInProcess
    }
    private var currentDisplayedWindow: UIWindow? {
        if #available(iOS 15, *) {
            let allScenes = UIApplication.shared.connectedScenes
            let windowScene = allScenes.first as? UIWindowScene
            return windowScene?.windows.first(where: \.isKeyWindow)
        } else {
            return UIApplication.shared.windows.first(where: \.isKeyWindow)
        }
    }
    
    // MARK: - Initialization
    
    required public init(adapter: DropDownTableAdapter) {
        self.dropDownAdapter = adapter
        self.containerView = UIView()
    }
    
    // MARK: - Public methods
    
    public func showDropDownList(on position: CGPoint, width: CGFloat) {
        showDropDownList(in: currentDisplayedWindow, on: position, width: width)
    }
    
    public func showDropDownList(below view: UIView, offset: CGFloat) {
        let spawnPosition = CGPoint(
            x: view.frame.origin.x,
            y: view.frame.origin.y + view.frame.height + offset
        )
        showDropDownList(in: view.superview, on: spawnPosition, width: view.frame.width)
    }
    
    public func hideDropDonwList() {
        guard !isAnimationInProgress else {
            return
        }
        isHideAnimtaionInProcess = true
        UIView.animate(withDuration: animationDuration) {
            self.containerView.frame.size = CGSize(width: self.containerView.frame.width, height: .zero)
            self.containerView.layoutIfNeeded()
        } completion: { _ in
            self.isHideAnimtaionInProcess = false
        }
    }
    
    // MARK: - Private properties
    
    private func showDropDownList(in view: UIView?, on position: CGPoint, width: CGFloat) {
        guard !isAnimationInProgress else {
            return
        }
        isShowAnimationInProcess = true
        removeOldDependencies()
        addNewDependecies(on: view)
        setSpawnLayoutParameters(x: position.x, y: position.y, width: width)
        subscribeOnFrameChangesAndAnimate()
    }
    
    private func setSpawnLayoutParameters(x: CGFloat, y: CGFloat, width: CGFloat) {
        containerView.frame = CGRect(x: x, y: y, width: width, height: .zero)
    }
    
    private func subscribeOnFrameChangesAndAnimate() {
        dropDownAdapter.onContentSizeDidChanged = { [weak self] newSize in
            if !(self?.isHideAnimtaionInProcess ?? true) {
                self?.updateContainerSizeWithAnimate(newSize)
            }
        }
    }
    
    private func addNewDependecies(on view: UIView?) {
        view?.addSubview(containerView)
        containerView.addSubview(dropDownAdapter.dropDownContent)
        pin(view: dropDownAdapter.dropDownContent, to: containerView)
    }
    
    private func removeOldDependencies() {
        containerView.removeFromSuperview()
        dropDownAdapter.dropDownContent.removeFromSuperview()
    }
    
    private func updateContainerSizeWithAnimate(_ newSize: CGSize) {
        containerView.frame.size = CGSize(width: newSize.width, height: newSize.height)
        UIView.animate(withDuration: animationDuration) {
            self.containerView.layoutIfNeeded()
        } completion: { _ in
            self.isShowAnimationInProcess = false
        }
    }
    
    private func pin(view: UIView, to anotherView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: anotherView.topAnchor),
            view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
            view.rightAnchor.constraint(equalTo: anotherView.rightAnchor)
        ])
    }
    
}
