import * as React from 'react';

import { Platform, Pressable, Text, View } from 'react-native';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Pressable onPress={() => EidSdk.initialize('', '', '')}>
        <Text style={{ color: 'black' }}>Nhấn để mở EID</Text>
      </Pressable>
    </View>
  );
};

export default App;
