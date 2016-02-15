//
//  IntroViewController.swift
//  carousel
//
//  Created by Tina Chen on 2/11/16.
//  Copyright © 2016 tinachen. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var tile1: UIImageView!
    @IBOutlet weak var tile2: UIImageView!
    @IBOutlet weak var tile3: UIImageView!
    @IBOutlet weak var tile4: UIImageView!
    @IBOutlet weak var tile5: UIImageView!
    @IBOutlet weak var tile6: UIImageView!
    
    var yOffsets : [Float] = [-285, -240, -415, -408, -480, -500]
    var xOffsets : [Float] = [-30, 75, -66, 10, -200, -15]
    var scales : [Float] = [1, 1.65, 1.7, 1.6, 1.65, 1.65]
    var rotations : [Float] = [-10, -10, 10, 10, 10, -10]
    var tiles = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introScrollView.delegate = self
        
        introScrollView.contentSize = CGSize(width: 320, height: 1136)
        
        tiles.append(tile1)
        tiles.append(tile2)
        tiles.append(tile3)
        tiles.append(tile4)
        tiles.append(tile5)
        tiles.append(tile6)
        introScrollView.contentOffset.y = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y
        for index in 0...5 {
            var tx = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: CGFloat(xOffsets[index]), r2Max: 0)
            var ty = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: CGFloat(yOffsets[index]), r2Max: 0)
            var scale = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: CGFloat(scales[index]), r2Max: 1)
            var rotation = convertValue(offset, r1Min: 0, r1Max: 568, r2Min: CGFloat(rotations[index]), r2Max: 0)
            tiles[index].transform = CGAffineTransformMakeRotation(rotation * CGFloat(M_PI / 180))
            tiles[index].transform = CGAffineTransformTranslate(tiles[index].transform, tx, ty)
            tiles[index].transform = CGAffineTransformScale(tiles[index].transform, scale, scale)
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
