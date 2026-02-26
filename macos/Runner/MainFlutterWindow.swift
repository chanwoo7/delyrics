import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    // Set minimum window size
    self.minSize = NSSize(width: 900, height: 720)

    // Set initial window size and center
    let initialSize = NSSize(width: 900, height: 720)
    if let screen = NSScreen.main {
      let screenFrame = screen.visibleFrame
      let x = screenFrame.midX - initialSize.width / 2
      let y = screenFrame.midY - initialSize.height / 2
      self.setFrame(NSRect(x: x, y: y, width: initialSize.width, height: initialSize.height), display: true)
    }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
