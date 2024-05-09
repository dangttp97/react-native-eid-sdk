import { NativeModules, Platform, requireNativeComponent } from 'react-native';
import React from 'react';
import { PersonalInfo, Eid } from './models';

type EidSdkType = {
  CameraFeedView?: ({ ...props }: CameraFeedProps) => React.JSX.Element;
  initialize: (
    apiKey: string,
    apiBaseUrl: string,
    customerCode: string
  ) => void;
  getPersonalInfo: (imageUrlStr: string) => Promise<PersonalInfo>;
  showScanFaceView: () => void;
  start: (result?: Eid) => void;
};

const { EidSdkModule } = NativeModules;
const NativeCameraFeedView = requireNativeComponent<any>('CameraFeedView');

type CameraFeedProps = {
  onReturnMRZData: (data: any) => void;
};
const CameraFeedView = ({ ...props }: CameraFeedProps) => {
  const onReturnMRZData = (event: any) => {
    if (!props.onReturnMRZData) {
      return;
    }

    props.onReturnMRZData(event.nativeEvent);
  };
  return <NativeCameraFeedView {...props} onReturnMRZData={onReturnMRZData} />;
};

const EidSdk: EidSdkType = Platform.select({
  ios: {
    CameraFeedView,
    initialize: EidSdkModule.initialize,
    getPersonalInfo: EidSdkModule.getPersonalInfo,
    showScanFaceView: () => {
      throw new Error('Not implemented');
    },
    start: EidSdkModule.presentViewController,
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
    start: EidSdkModule.start,
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
    start: () => {
      throw new Error('Not implemented');
    },
  },
});

export default EidSdk;
