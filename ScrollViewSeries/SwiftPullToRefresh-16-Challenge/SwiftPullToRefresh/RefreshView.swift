import UIKit

private let sceneHeight: CGFloat = 120

class RefreshView: UIView {
  private unowned var scrollView: UIScrollView
  var progressPercentage: CGFloat = 0

  var refreshItems = [RefreshItem]()

  required init?(coder aDecoder: NSCoder) {
    scrollView = UIScrollView()
    assert(false, "use init(frame:scrollView:)")
    super.init(coder: aDecoder)
  }

  init(frame: CGRect, scrollView: UIScrollView) {
    self.scrollView = scrollView
    super.init(frame: frame)
    clipsToBounds = true

    updateBackgroundColor()
    setupRefreshItems()
  }

  func setupRefreshItems() {
    let groundImageView = UIImageView(image: UIImage(named: "ground"))
    groundImageView.layer.borderColor = UIColor.blueColor().CGColor
    groundImageView.layer.borderWidth = 2
    
    let buildingsImageView = UIImageView(image: UIImage(named: "buildings"))
    buildingsImageView.layer.borderColor = UIColor.brownColor().CGColor
    buildingsImageView.layer.borderWidth = 2
    
    let sunImageView = UIImageView(image: UIImage(named: "sun"))
    sunImageView.layer.borderColor = UIColor.redColor().CGColor
    sunImageView.layer.borderWidth = 2
    
    let catImageView = UIImageView(image: UIImage(named: "cat"))
    let capeBackImageView = UIImageView(image: UIImage(named: "cape_back"))
    let capeFrontImageView = UIImageView(image: UIImage(named: "cape_front"))

    refreshItems = [
      RefreshItem(view: buildingsImageView,
        centerEnd: CGPoint(x: CGRectGetMidX(bounds),
          y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds) - CGRectGetHeight(buildingsImageView.bounds) / 2),
        parallaxRatio: 1.5, sceneHeight: sceneHeight),
      RefreshItem(view: sunImageView,
        centerEnd: CGPoint(x: CGRectGetWidth(bounds) * 0.1,
          y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds) - CGRectGetHeight(sunImageView.bounds)),
        parallaxRatio: 3, sceneHeight: sceneHeight),
      RefreshItem(view: groundImageView,
        centerEnd: CGPoint(x: CGRectGetMidX(bounds),
          y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2),
        parallaxRatio: 0.5, sceneHeight: sceneHeight),
      RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(capeBackImageView.bounds)/2), parallaxRatio: -1, sceneHeight: sceneHeight),
      RefreshItem(view: catImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(catImageView.bounds)/2), parallaxRatio: 1, sceneHeight: sceneHeight),
      RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(capeFrontImageView.bounds)/2), parallaxRatio: -1, sceneHeight: sceneHeight),
    ]

    for refreshItem in refreshItems {
      addSubview(refreshItem.view)
    }
  }

  func updateBackgroundColor() {
    let value = progressPercentage * 0.7 + 0.2
    backgroundColor = UIColor(red: value, green: value, blue: value, alpha: 1.0)
  }

  func updateRefreshItemPositions() {
    for refreshItem in refreshItems {
      refreshItem.updateViewPositionForPercentage(progressPercentage)
    }
  }
}

extension RefreshView: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let refreshViewVisibleHeight = max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))
    progressPercentage = min(1, refreshViewVisibleHeight / sceneHeight)

    updateBackgroundColor()
    updateRefreshItemPositions()
  }
}
