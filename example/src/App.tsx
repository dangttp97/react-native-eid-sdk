/* eslint-disable react-native/no-inline-styles */
import * as React from 'react';

import { Image, ScrollView, Text, View } from 'react-native';
import EidSdk, { Eid } from 'react-native-eid-sdk';

const App = () => {
  React.useEffect(() => {
    EidSdk.initialize(
      'QdDItkzUEtrPfSmocKl40to2EVnY6zIy',
      'https://api.dkviet.com/',
      'FINVIET'
    );
  }, []);

  const [data, setData] = React.useState<Eid | undefined>(undefined);

  return (
    <View
      style={{
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        paddingTop: 60,
        paddingBottom: 20,
        paddingHorizontal: 20,
      }}
    >
      {/* {!data ? (
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
      )} */}
      <EidSdk.CameraFeedView
        onReturnCitizenData={(data) => {
          console.log('Data', data);
          setData(data);
        }}
        style={{ borderRadius: 10 }}
      />
      <ScrollView
        showsVerticalScrollIndicator={false}
        style={{
          flex: 1,
          marginTop: 20,
          width: '100%',
          backgroundColor: '#00000033',
          borderRadius: 10,
        }}
        contentContainerStyle={{
          paddingHorizontal: 10,
          paddingTop: 20,
          paddingBottom: 20,
        }}
      >
        <View
          style={{
            justifyContent: 'center',
            alignItems: 'center',
            marginBottom: 30,
          }}
        >
          <Image
            source={{
              uri: data?.personOptionalDetails?.face
                ? `data:image/jpeg;base64,${data.personOptionalDetails.face}`
                : '',
            }}
            width={200}
            height={200}
          />
        </View>
        <View style={{ height: 20 }} />
        {data &&
          data.personOptionalDetails &&
          Object.entries(data.personOptionalDetails).map((value) => {
            if (value[0] !== 'face') {
              return (
                <View>
                  <Text
                    style={{
                      flex: 1,
                      color: 'black',
                      fontSize: 12,
                      marginBottom: 20,
                    }}
                  >
                    <Text
                      style={{
                        color: 'black',
                        fontSize: 13,
                        fontWeight: '600',
                        marginBottom: 5,
                      }}
                    >
                      {`${value[0]}: \n`}
                    </Text>
                    {value[1]}
                  </Text>
                  <View
                    style={{
                      height: 2,
                      backgroundColor: 'darkgrey',
                      marginBottom: 20,
                    }}
                  />
                </View>
              );
            } else {
              return undefined;
            }
          })}
      </ScrollView>
    </View>
  );
};

export default App;
