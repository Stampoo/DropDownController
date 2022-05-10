### DropDownController

Simple view with custom content and animation like drop-down list

### Example:

<img src="https://user-images.githubusercontent.com/44356536/156922800-0af5386b-8f8c-4197-9610-e72abc387237.gif" width="29%" height="29%"/>

### How usage:

1. Create instanse of controller on drop-down content and adapter

```swift
final class ExampleDropListViewController: UIViewController {
    
    private let filterView = FilterView()
    private let dropDownTableAdapter = DropDownTableAdapter()
    private lazy var dropDownController = DropDownController(adapter: dropDownTableAdapter)
``` 

2. Create content adapter(for `UITableView` in example)

```swift
   // Content can be anything, create your content adapter and sign with DropDownAdapterProtocol
   private func getAdapter(for table: UITableView) -> AnyObject {
        table.backgroundColor = .black
        table.layer.cornerRadius = 12
        table.separatorStyle = .none
        
        // Table adapter can be AnyObject, simple class or self
        let adapter = BaseTableAdapter(tableView: table)
        let model = BasicCell.Model(title: "Test example with text", backgroundColor: .gray)
        let cellController = CellController<BasicCell>(model: model)
        adapter.append(cellController: cellController)
        adapter.append(cellController: cellController)
        adapter.append(cellController: cellController)
        return adapter
    }
```

3. Inject adapter with custom content

```swift
filterView.onDidTouchTriggered { isOpen in
    if isOpen {
        self.dropDownTableAdapter.injectContentAdapter(self.getAdapter(for:))
        self.dropDownController.showDropDownList(below: self.filterView, offset: 8)
    } else {
        self.dropDownController.hideDropDonwList()
    }
}
```
