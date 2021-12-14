var exec = require('cordova/exec')

var shareextension = {}

shareextension.onFiles = function (onSuccess, onError) {
  exec(onSuccess, onError, 'ShareExtension', 'onFiles', [])
}

shareextension.fetchUrls = function (onSuccess, onError) {
  exec(onSuccess, onError, 'ShareExtension', 'fetchUrls', [])
}

module.exports = shareextension
