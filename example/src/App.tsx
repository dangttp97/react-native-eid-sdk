import * as React from 'react';

import { Pressable, Text, View } from 'react-native';
import { launchCamera } from 'react-native-image-picker';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  const handleOpenCamera = async () => {
    const imageResponse = await launchCamera({
      mediaType: 'photo',
    });

    const info = await EidSdk.getPersonalInfo(
      imageResponse?.assets?.[0]?.uri ?? ''
    );

    console.log('MRZ info', info);
  };

  return (
    <View>
      <Pressable
        onPress={() => handleOpenCamera()}
        style={{ backgroundColor: 'gray', padding: 10 }}
      >
        <Text style={{ color: 'black' }}>Open camera</Text>
      </Pressable>
    </View>
  );
};

export default App;
