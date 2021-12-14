@objc(ShareExtension) class ShareExtension: CDVPlugin {
    var _command: CDVInvokedUrlCommand?

    override func pluginInitialize() {
        super.pluginInitialize()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sendUrls),
            name: NSNotification.Name("CDVPluginHandleOpenURLNotification"),
            object: nil
        )
    }


    func getUserDefaults() -> UserDefaults? {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
            return nil
        }
        return UserDefaults(suiteName: "group.\(bundleIdentifier).shareextension")
    }
    
    func getUrlResult() -> CDVPluginResult? {
        let userDefaults = getUserDefaults()
        let urls = userDefaults?.array(forKey: "urls")
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: urls)
        return result
    }
    
    func clearUrl() {
        let userDefaults = getUserDefaults()
        userDefaults?.removeObject(forKey: "urls")
    }
    
    @objc func sendUrls() {
        let result = getUrlResult()
        result?.keepCallback = true
        if ((_command) != nil) {
            self.commandDelegate.send(result, callbackId: _command?.callbackId)
            clearUrl()
        }
    }

    @objc(onFiles:) func onFiles(command: CDVInvokedUrlCommand) {
        self._command = command
    }
    
    
    @objc(fetchUrls:) func fetchUrls(command: CDVInvokedUrlCommand) {
        let result = getUrlResult()
        self.commandDelegate.send(result, callbackId: command.callbackId)
        clearUrl()
    }
}
