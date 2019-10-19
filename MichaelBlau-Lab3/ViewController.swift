//
//  ViewController.swift
//  MichaelBlau-Lab3
//
//  Created by michael blau on 9/20/19.
//  Copyright © 2019 michael blau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lineCanvas: DrawView!
    var currentLine: Line?
    var currentPenSize:Float = 10.0
    var currentColor:UIColor = UIColor.red
    var currentOpacity: CGFloat = 1.0

    
    @IBOutlet weak var penSizeSlider: UISlider!
    @IBAction func penSizeChanged(_ sender: Any) {
        currentPenSize = penSizeSlider.value * 60
    }
    
    
    @IBOutlet weak var penOpacity: UISlider!
    @IBAction func penOpacityChanged(_ sender: Any) {
        currentOpacity = CGFloat(penOpacity.value)
    }
    
    @IBAction func redPen(_ sender: Any) {
        currentColor = UIColor.red
    }
    
    @IBAction func orangePen(_ sender: Any) {
        currentColor = UIColor.orange
    }
    
    @IBAction func yellowPen(_ sender: Any) {
        currentColor = UIColor.yellow
    }
    
    @IBAction func greenPen(_ sender: Any) {
        currentColor = UIColor.green
    }
    
    @IBAction func bluePen(_ sender: Any) {
        currentColor = UIColor.blue
    }

    @IBAction func clearPressed(_ sender: Any) {
        lineCanvas.lines = []
        lineCanvas.theLine = nil
    }
    
    @IBAction func eraser(_ sender: Any) {
        currentColor = UIColor.white
    }
    
    @IBAction func undoPressed(_ sender: Any) {
        if lineCanvas.lines.count > 0{
            let index = lineCanvas.lines.count-1
            lineCanvas.theLine = nil
            lineCanvas.lines.remove(at: index)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: true)
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: lineCanvas) else {
            return
        }

        currentLine = Line(dots: [], color: currentColor, size: CGFloat(currentPenSize),opacity:currentOpacity)
        currentLine?.dots.append(touchPoint)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: lineCanvas) else {
            return
        }
        currentLine?.dots.append(touchPoint)
        if let line = currentLine{
            lineCanvas.theLine = line
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let line = currentLine{
            lineCanvas.lines.append(line)
            lineCanvas.theLine = nil
        }
    }
    
    @IBAction func saveDrawing(_ sender: Any) {
        let renderer = UIGraphicsImageRenderer(size: lineCanvas.bounds.size)
        let image = renderer.image { ctx in
            lineCanvas.drawHierarchy(in: lineCanvas.bounds, afterScreenUpdates: true)
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        // credit to www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
    
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "There was an error trying to save your drawing", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your drawing has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    // credit for the above function is from www.hackingwithswift.com/read/13/5/saving-to-the-ios-photo-library

}

