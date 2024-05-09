import * as React from 'react';

import { Pressable, ScrollView, Text, View } from 'react-native';
import EidSdk from 'react-native-eid-sdk';

const App = () => {
  React.useEffect(() => {
    EidSdk.initialize(
      'QdDItkzUEtrPfSmocKl40to2EVnY6zIy',
      'https://api.dkviet.com/',
      'FINVIET'
    );
  }, []);

  const [data, setData] = React.useState<EidSdk.Eid | undefined>(undefined);

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      {!data ? (
        <Pressable
          onPress={() => {
            EidSdk.start((data) => setData(data));
          }}
        >
          <Text style={{ color: 'black' }}>Nhấn để mở EID</Text>
        </Pressable>
      ) : (
        <ScrollView
          style={{
            paddingHorizontal: 20,
            paddingTop: 60,
            paddingBottom: 20,
          }}
        >
          <Text style={{ color: 'black' }}>
            {JSON.stringify(data, undefined, 2)}
          </Text>
        </ScrollView>
      )}
    </View>
  );
};

export default App;
