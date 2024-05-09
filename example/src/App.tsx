import * as React from 'react';

import { Platform, Pressable, Text, View } from 'react-native';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Pressable
        onPress={() => {
          // EidSdk.initialize(
          //   'gYKcU0x14PO07mPp2eT22mce3La9JrOB',
          //   'https://api.jth.vn',
          //   'JTH'
          // );
          EidSdk.initialize(
            'QdDItkzUEtrPfSmocKl40to2EVnY6zIy',
            'https://api.dkviet.com/',
            'FINVIET'
          );
        }}
      >
        <Text style={{ color: 'black' }}>Nhấn để mở EID</Text>
      </Pressable>
    </View>
  );
};

export default App;
