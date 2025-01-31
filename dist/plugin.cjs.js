'use strict';

var core = require('@capacitor/core');

const LocalNetworkPermissionChecker = core.registerPlugin('LocalNetworkPermissionChecker', {
    web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.LocalNetworkPermissionCheckerWeb()),
});

class LocalNetworkPermissionCheckerWeb extends core.WebPlugin {
    getLocalNetworkPermissionStatus() {
        throw new Error('Method not implemented on web.');
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    LocalNetworkPermissionCheckerWeb: LocalNetworkPermissionCheckerWeb
});

exports.LocalNetworkPermissionChecker = LocalNetworkPermissionChecker;
//# sourceMappingURL=plugin.cjs.js.map
