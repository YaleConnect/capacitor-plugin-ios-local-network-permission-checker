import { WebPlugin } from '@capacitor/core';

import type { LocalNetworkPermissionCheckerPlugin } from './definitions';

export class LocalNetworkPermissionCheckerWeb extends WebPlugin implements LocalNetworkPermissionCheckerPlugin {
  getLocalNetworkPermissionStatus(): Promise<{ status: 'notDetermined' | 'denied' | 'granted'; }> {
    throw new Error('Method not implemented on web.');
  }
}
