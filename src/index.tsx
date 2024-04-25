import { NativeModules, Platform } from 'react-native';
import { PersonalInfo } from './models';

type EidSdkType = {
  initialize: (
    apiKey: string,
    apiBaseUrl: string,
    customerCode: string
  ) => void;
  getPersonalInfo: (imageUrlStr: string) => Promise<PersonalInfo>;
  showScanFaceView: () => void;
};

const { EidSdkModule } = NativeModules;

const EidSdk: EidSdkType = Platform.select({
  ios: {
    initialize: EidSdkModule.initialize,
    getPersonalInfo: EidSdkModule.getPersonalInfo,
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
  },
  android: {
    initialize: () => {
      throw new Error('Not implemented');
    },
    getPersonalInfo: () => {
      throw new Error('Not implemented');
    },
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
  },
  default: {
    initialize: () => {
      throw new Error('Not implemented');
    },
    getPersonalInfo: () => {
      throw new Error('Not implemented');
    },
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
  },
});

export default EidSdk;
