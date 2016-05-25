public class FeedbackBadgesCell: UICollectionViewCell {
    private let kCardInset: CGFloat = 3
    private let badgeView = UIImageView()


    public func beginFunAnimation() {
        let circleView = UIView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0x76c5c6, 1)
        contentView.insertSubview(circleView, belowSubview: badgeView)

        badgeView.image = UIImage(named:"icon-fun_animated_selected.png")

        UIView.animateKeyframesWithDuration(1.15, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0.15, relativeDuration: 0.35, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(self.badgeView.transform, CGFloat(M_PI/6))
                self.badgeView.transform = rotate
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(self.badgeView.transform, CGFloat(-M_PI/6))
                self.badgeView.transform = rotate
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.15, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(self.badgeView.transform, CGFloat(M_PI/12))
                self.badgeView.transform = rotate
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.9, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(self.badgeView.transform, CGFloat(-M_PI/12))
                self.badgeView.transform = rotate
            })
            
            UIView.addKeyframeWithRelativeStartTime(1, relativeDuration: 0.15, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(self.badgeView.transform, CGFloat(0))
                self.badgeView.transform = rotate
            })
            
            }, completion: nil)
    }
    
    public func beginEducation() {
        badgeView.image = UIImage(named: "icon-educational_cap_animated_selected.png")
        
        let circleView = UIView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0xb3cb75, 1)
        contentView.insertSubview(circleView, belowSubview: badgeView)
        
        let tasselImageView = UIImageView.init(image: UIImage(named:"icon-educational_tassel_animated_selected.png"))
        tasselImageView.frame = CGRectMake(3, 3, 38, 38)
        tasselImageView.layer.anchorPoint = CGPointMake(7/40, 19/40)
        contentView.insertSubview(tasselImageView, belowSubview: badgeView)
        
        let translate = CGAffineTransformMakeTranslation(0, 0)
        tasselImageView.transform = translate
        
        UIView.animateKeyframesWithDuration(1.5, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { () -> Void in
                let translate = CGAffineTransformMakeTranslation(-12, 0)
                tasselImageView.transform = translate
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(tasselImageView.transform, CGFloat(M_PI/12))
                tasselImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(tasselImageView.transform, CGFloat(-2 * M_PI/12))
                tasselImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.2, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(tasselImageView.transform, CGFloat(2 * M_PI/12))
                tasselImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.3, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(tasselImageView.transform, CGFloat(-M_PI/12))
                tasselImageView.transform = rotate
                
            })
            
        }, completion: nil)
    }
    
    public func beginEnlarge() {
        let circleView = UIView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0x0088b0, 0.85)
        contentView.insertSubview(circleView, belowSubview: badgeView)
        
        badgeView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        UIView.animateWithDuration(1.0, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.badgeView.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: nil)
    }
    
    public func beginInspiring() {
        let circleView = UIImageView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0x32adde, 0.85)
        circleView.image = UIImage(named: "icon-inspiring_selected.png")
        contentView.insertSubview(circleView, belowSubview: badgeView)
        
        badgeView.alpha = 0.6
        UIView.animateWithDuration(1.0, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.badgeView.image = self.badgeView.image?.imageWithRenderingMode(.AlwaysTemplate)
            self.badgeView.tintColor = UIColorFromRGBWithAlpha(0xfbbc60, 1)
            self.badgeView.alpha = 0

            }, completion: nil)
    }
    
    public func beginInnovative() {
        let circleView = UIView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19;
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0xfec456, 1)
        contentView.insertSubview(circleView, belowSubview: badgeView)
        
        badgeView.image = UIImage(named: "icon-innovative_people_animated_selected.png")
        let translate = CGAffineTransformMakeTranslation(-3, 0)
        let rotate = CGAffineTransformMakeRotation(CGFloat(-M_PI/24))
        badgeView.transform = CGAffineTransformConcat(translate, rotate)
        
        UIView.animateWithDuration(1.5, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            let translate = CGAffineTransformMakeTranslation(3, 0)
            let rotate = CGAffineTransformMakeRotation(CGFloat(M_PI/24))
            self.badgeView.transform = CGAffineTransformConcat(translate, rotate)
        }, completion: nil)
        

        
    }
    
    public func beginThankYou() {
        let circleView = UIView.init(frame: CGRectMake(kCardInset, kCardInset, 38, 38))
        circleView.alpha = 1
        circleView.layer.cornerRadius = 19;
        circleView.backgroundColor = UIColorFromRGBWithAlpha(0xf47a62, 1)
        contentView.insertSubview(circleView, belowSubview: badgeView)
        
        let boxTopImageView = UIImageView.init(image: UIImage(named:"icon-thank-you_animated_top_selected.png"))
        boxTopImageView.frame = CGRectMake(3, 3, 38, 38)
        contentView.insertSubview(boxTopImageView, belowSubview: badgeView)
        
        let translate = CGAffineTransformMakeTranslation(0, 0)
        boxTopImageView.transform = translate
        UIView.animateKeyframesWithDuration(1.5, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.5, animations: { () -> Void in
                let translate = CGAffineTransformMakeTranslation(0, -5)
                boxTopImageView.transform = translate
            })

            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(M_PI/12))
                boxTopImageView.transform = rotate
                
            })

            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(-2 * M_PI/12))
                boxTopImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1 * 2, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(2 * M_PI/12))
                boxTopImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1 * 3, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(-2 * M_PI/12))
                boxTopImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1 * 4, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(2 * M_PI/12))
                boxTopImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5 + 0.1 * 5, relativeDuration: 0.1, animations: { () -> Void in
                let rotate = CGAffineTransformRotate(boxTopImageView.transform, CGFloat(-M_PI/12))
                boxTopImageView.transform = rotate
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(1, relativeDuration: 0.5, animations: { () -> Void in
                let translate = CGAffineTransformMakeTranslation(0, 0)
                boxTopImageView.transform = translate
            })
            
        }, completion: nil)
    }
}
