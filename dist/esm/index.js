import { registerPlugin } from '@capacitor/core';
const LocalNetworkPermissionChecker = registerPlugin('LocalNetworkPermissionChecker', {
    web: () => import('./web').then((m) => new m.LocalNetworkPermissionCheckerWeb()),
});
export * from './definitions';
export { LocalNetworkPermissionChecker };
//# sourceMappingURL=index.js.map