export interface LocalNetworkPermissionCheckerPlugin {
  getLocalNetworkPermissionStatus(): Promise<{ status: 'notDetermined' | 'denied' | 'granted' }>;
}
