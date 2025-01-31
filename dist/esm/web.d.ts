import { WebPlugin } from '@capacitor/core';
import type { LocalNetworkPermissionCheckerPlugin } from './definitions';
export declare class LocalNetworkPermissionCheckerWeb extends WebPlugin implements LocalNetworkPermissionCheckerPlugin {
    getLocalNetworkPermissionStatus(): Promise<{
        status: 'notDetermined' | 'denied' | 'granted';
    }>;
}
