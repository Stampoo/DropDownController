//
//  DropDownControllerProtocol.swift
//  
//
//  Created by Князьков Илья on 05.03.2022.
//

import Foundation
import UIKit

public protocol DropDownControllerProtocol {
    
    associatedtype Adapter: DropDownAdapterProtocol
    
    var dropDownAdapter: Adapter { get }
    var containerView: UIView { get }
    var animationDuration: TimeInterval { get set }
    
    init(adapter: Adapter)
    
    func showDropDownList(on position: CGPoint, width: CGFloat)
    func showDropDownList(below view: UIView, offset: CGFloat)
    func hideDropDonwList()
    
}
