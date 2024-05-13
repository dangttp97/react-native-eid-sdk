import {
  NativeModules,
  NativeSyntheticEvent,
  Platform,
  ViewProps,
  requireNativeComponent,
} from 'react-native';
import React, { useState } from 'react';
import { PersonalInfo, Eid } from './models';

type CameraFeedProps = ViewProps & {
  onReturnCitizenData: (data: Eid) => void;
};

type EidSdkType = {
  CameraFeedView: ({ ...props }: CameraFeedProps) => React.JSX.Element;
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
const NativeCameraFeedView = requireNativeComponent<
  ViewProps & {
    onReturnCitizenData: (event: NativeSyntheticEvent<any>) => void;
  }
>('CameraFeedView');

const CameraFeedView = ({ ...props }: CameraFeedProps) => {
  const [width, setWidth] = useState(0);
  const onReturnCitizenData = (event: NativeSyntheticEvent<any>) => {
    if (!props.onReturnCitizenData) {
      return;
    }

    props.onReturnCitizenData({ personOptionalDetails: event.nativeEvent });
  };

  return (
    <NativeCameraFeedView
      {...props}
      onReturnCitizenData={onReturnCitizenData}
      onLayout={(e) => {
        setWidth(e.nativeEvent.layout.width);
      }}
      style={[{ width: '100%', height: (width * 2) / 3 }, props.style]}
    />
  );
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
    CameraFeedView: (_: CameraFeedProps) => <></>,
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
    CameraFeedView: (_: CameraFeedProps) => <></>,
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

export { Eid };

export default EidSdk;
