//
//  DrawView.swift
//  MichaelBlau-Lab3
//
//  Created by michael blau on 9/25/19.
//  Copyright © 2019 michael blau. All rights reserved.
//

import UIKit

class DrawView: UIView {
    var theLine:Line?{
        didSet{
            setNeedsDisplay()  // CALLS THE DRAW FUNCTION AND UPDATES VIEW
        }
    }
    
    var lines:[Line] = []{
        didSet{
            setNeedsDisplay() 
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let x = (first.x + second.x)/2
        let y = (first.y + second.y)/2
        return CGPoint(x: x, y: y)
    }
    
    private func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath() //Create the path object
        if(points.count < 2){ //There are no points to add to this path
            return path
        }
        path.move(to: points[0]) //Start the path on the first point
        for i in 1..<points.count - 1{
            let firstMidpoint = midpoint(first: path.currentPoint, second:
                points[i]) //Get midpoint between the path's last point and the next one in the array
            let secondMidpoint = midpoint(first: points[i], second:
                points[i+1]) //Get midpoint between the next point in the array and the one after it
            path.addCurve(to: secondMidpoint, controlPoint1: firstMidpoint,
                          controlPoint2: points[i]) //This creates a cubic Bezier curve using math!
        }
        return path
    }
    
    func drawLine(_ line:Line){
        let path = createQuadPath(points: line.dots)
        path.lineWidth = line.size
        line.color.setStroke()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.stroke(with: .normal, alpha: line.opacity)
        if line.color == UIColor.white{
            path.stroke(with: .normal, alpha: 1.0)
        }
        else{
            path.stroke(with: .normal, alpha: line.opacity)
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        print("SET NEEDS DISPLAY")
        for line in lines{
            drawLine(line)
        }
        if(theLine != nil){
            drawLine(theLine!)
        }
        
    }
    
 

}
