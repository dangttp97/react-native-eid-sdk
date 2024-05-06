import { NativeModules, Platform, requireNativeComponent } from 'react-native';
import React from 'react';
import { PersonalInfo } from './models';

type EidSdkType = {
  CameraFeedView?: ({ ...props }: CameraFeedProps) => React.JSX.Element;
  initialize: (
    apiKey: string,
    apiBaseUrl: string,
    customerCode: string
  ) => void;
  getPersonalInfo: (imageUrlStr: string) => Promise<PersonalInfo>;
  showScanFaceView: () => void;
};

const { EidSdkModule } = NativeModules;
const CameraFeedView = requireNativeComponent('CameraFeedView');

type CameraFeedProps = {
  onReturnMRZData: (data: any) => void;
};
const CameraFeed = ({ ...props }: CameraFeedProps) => {
  const onReturnMRZData = (event: any) => {
    if (!props.onReturnMRZData) {
      return;
    }

    props.onReturnMRZData(event.nativeEvent);
  };
  return <CameraFeedView {...props} onReturnMRZData={onReturnMRZData} />;
};

const EidSdk: EidSdkType = Platform.select({
  ios: {
    CameraFeedView: CameraFeed,
    initialize: EidSdkModule.initialize,
    getPersonalInfo: EidSdkModule.getPersonalInfo,
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
  },
  android: {
    CameraFeedView: undefined,
    initialize: EidSdkModule.initialize,
    getPersonalInfo: () => {
      throw new Error('Not implemented');
    },
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
  },
  default: {
    CameraFeedView: undefined,
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
