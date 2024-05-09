import * as React from 'react';

import { Pressable, Text, View } from 'react-native';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  React.useEffect(() => {
    EidSdk.initialize(
      'QdDItkzUEtrPfSmocKl40to2EVnY6zIy',
      'https://api.dkviet.com/',
      'FINVIET'
    );
  }, []);

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Pressable
        onPress={() => {
          EidSdk.start();
        }}
      >
        <Text style={{ color: 'black' }}>Nhấn để mở EID</Text>
      </Pressable>
    </View>
  );
};

export default App;
