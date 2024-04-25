import * as React from 'react';

import { Pressable, Text, View } from 'react-native';
import { launchCamera } from 'react-native-image-picker';
import RNNationalDatabase from 'react-native-national-db-lib';

const App = () => {
  const handleOpenCamera = async () => {
    const imageResponse = await launchCamera({
      mediaType: 'photo',
    });

    const info = await RNNationalDatabase.getMRZInfo(
      imageResponse?.assets?.[0]?.uri ?? '',
      0
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
