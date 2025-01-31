import { registerPlugin } from '@capacitor/core';

import type { LocalNetworkPermissionCheckerPlugin } from './definitions';

const LocalNetworkPermissionChecker = registerPlugin<LocalNetworkPermissionCheckerPlugin>('LocalNetworkPermissionChecker', {
  web: () => import('./web').then((m) => new m.LocalNetworkPermissionCheckerWeb()),
});

export * from './definitions';
export { LocalNetworkPermissionChecker };
