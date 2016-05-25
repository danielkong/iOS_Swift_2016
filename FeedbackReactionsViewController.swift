    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedbackBadgesCell", forIndexPath: indexPath) as! FeedbackBadgesCell
        if let filename = feedbackOptionModelList?.createFileName(indexPath.item, valueForKey: "iconID", fileExtension: "_selected.png") {
            cell.image = UIImage(named: filename)
            if filename == "icon-educational_selected.png" {
                cell.beginEducation()
            } else if filename == "icon-fun_selected.png" {
                cell.beginFunAnimation()
            } else if filename == "icon-general_selected.png" {
                cell.image = UIImage(named: "icon-general_animated_selected.png")
                cell.beginEnlarge()
            } else if filename == "icon-teamwork_selected.png" {
                cell.beginAnimation()
            } else if filename == "icon-inspiring_selected.png" {
                cell.image = UIImage(named: "icon-inspiring_animated_selected.png")
                cell.beginInspiring()
            } else if filename == "icon-innovative_selected.png" {
                cell.beginInnovative()
            } else if filename == "icon-thank-you_selected.png" {
                cell.image = UIImage(named:"icon-thank-you_animated_bottom_selected")
                cell.beginThankYou()
            }
        }
        return cell
    }
