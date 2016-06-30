import UIKit

private let refreshViewHeight: CGFloat = 200

class RefreshableTableViewController: UITableViewController {
  var refreshView: RefreshView!

  override func viewDidLoad() {
    super.viewDidLoad()

    refreshView = RefreshView(frame: CGRect(x: 0, y: -refreshViewHeight, width: CGRectGetWidth(view.bounds), height: refreshViewHeight), scrollView: tableView)
    refreshView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(refreshView, atIndex: 0)
  }

  override func scrollViewDidScroll(scrollView: UIScrollView) {
    refreshView.scrollViewDidScroll(scrollView)
  }
//}

//extension RefreshableTableViewController: UITableViewDataSource {
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

    cell.textLabel?.text = "Cell \(indexPath.row)"

    return cell
  }
}
