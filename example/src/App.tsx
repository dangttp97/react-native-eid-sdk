import { View, Text, TouchableOpacity } from 'react-native';
import React from 'react';
import EidSdk from 'react-native-eid-sdk'

export default function App() {
  const startEIDSDK = () =>{
    EidSdk.initialize("","","")
  }
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <TouchableOpacity
      onPress={startEIDSDK}
        style={{
          backgroundColor: 'blue',
          paddingHorizontal: 10,
          paddingVertical: 6,
          borderRadius: 5,
        }}
      >
        <Text style={{ color: 'white', fontSize: 18 }}>
          Start Native eid sdk
        </Text>
      </TouchableOpacity>
    </View>
  );
}
