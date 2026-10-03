import AppKit

final class CounterController: NSObject, NSApplicationDelegate {
    private let target = 150
    private let defaultsKey = "counter"
    private var count: Int
    private var statusItem: NSStatusItem!
    private var menu: NSMenu!

    override init() {
        count = UserDefaults.standard.integer(forKey: defaultsKey)
        super.init()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        guard let button = statusItem.button else { return }

        button.target = self
        button.action = #selector(statusItemClicked(_:))
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        button.font = NSFont.monospacedDigitSystemFont(ofSize: 13, weight: .medium)
        button.toolTip = "Counter150: нажмите, чтобы увеличить счетчик"
        updateTitle()

        menu = NSMenu()
        menu.addItem(withTitle: "Сбросить", action: #selector(resetCounter), keyEquivalent: "r")
        menu.addItem(.separator())
        menu.addItem(withTitle: "Выйти", action: #selector(quit), keyEquivalent: "q")
        menu.items.forEach { $0.target = self }
    }

    @objc private func statusItemClicked(_ sender: Any?) {
        guard let button = statusItem.button,
              let event = NSApp.currentEvent else { return }

        if event.type == .rightMouseUp || event.modifierFlags.contains(.control) {
            menu.popUp(positioning: nil, at: NSPoint(x: button.bounds.midX, y: 0), in: button)
            return
        }

        count += 1
        UserDefaults.standard.set(count, forKey: defaultsKey)
        updateTitle()
    }

    @objc private func resetCounter() {
        count = 0
        UserDefaults.standard.set(count, forKey: defaultsKey)
        updateTitle()
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }

    private func updateTitle() {
        statusItem?.button?.title = "\(count)/\(target)"
        statusItem?.button?.setAccessibilityLabel("Счетчик: \(count) из \(target)")
    }
}

let application = NSApplication.shared
let delegate = CounterController()
application.delegate = delegate
application.run()
