import * as React from 'react';

import { Platform, View } from 'react-native';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  return (
    <View>
      {Platform.OS === 'ios' && (
        <EidSdk.CameraFeedView onReturnMRZData={(data) => console.log(data)} />
      )}
    </View>
  );
};

export default App;
