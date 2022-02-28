import UIKit

class ColorButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        let height = frame.height
        let width = frame.width
        var minSideSize: CGFloat {
            return (height <= width) ? (width) : (height)
        }
        layer.cornerRadius = minSideSize / 2
    }
}
