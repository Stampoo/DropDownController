//
//  DropDownTableAdapter.swift
//  
//
//  Created by Князьков Илья on 05.03.2022.
//

import Foundation
import UIKit
import Combine

public class DropDownTableAdapter: DropDownAdapterProtocol {
    
    // MARK: - Nested types
    
    public typealias DropDownContent = UITableView
    
    // MARK: - Public properties
    
    public var dropDownContent: DropDownContent {
        tableView
    }
    
    public var onContentSizeDidChanged: ((CGSize) -> Void)?
    
    // MARK: - Private methods
    
    private let tableView = UITableView()
    private var adapter: AnyObject?
    private var cancelablesPublishers: Set<AnyCancellable> = []
    
    // MARK: - Initialization
    
    public init() {
        subscribeOnContentSizeDidChanged()
    }
    
    // MARK: - Internal methods
  
    public func injectContentAdapter(_ adapterInjector: (_ tableView: DropDownContent) -> AnyObject) {
        self.adapter = adapterInjector(tableView)
    }
    
    // MARK: - Private methods
    
    private func subscribeOnContentSizeDidChanged() {
        tableView.publisher(for: \.contentSize)
            .receive(on: RunLoop.main)
            .sink { [weak self] newContentSize in
                self?.onContentSizeDidChanged?(newContentSize)
            }
            .store(in: &cancelablesPublishers)
    }

}
