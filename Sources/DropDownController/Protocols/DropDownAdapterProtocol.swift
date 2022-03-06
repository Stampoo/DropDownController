//
//  DropDownAdapterProtocol.swift
//  
//
//  Created by Князьков Илья on 04.03.2022.
//

import UIKit

public protocol DropDownAdapterProtocol {
    
    associatedtype DropDownContent
    
    var dropDownContent: DropDownContent { get }
    var onContentSizeDidChanged: ((_ newSize: CGSize) -> Void)? { get set }
    
    func injectContentAdapter(_ adapterInjector: (_ dropDownContent: DropDownContent) -> AnyObject)
    
}
