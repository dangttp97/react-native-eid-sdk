import { View, Text, TouchableOpacity, Image, ScrollView } from 'react-native';
import React, { useEffect, useState } from 'react';
import EidSdk from 'react-native-eid-sdk';
import { Eid } from '../../src/models';

export default function App() {
  const [data, setData] = useState<Eid | null>(null);

  useEffect(()=>{
    EidSdk.initialize("gYKcU0x14PO07mPp2eT22mce3La9JrOB","https://api.jth.vn/","JTH")
    // EidSdk.initialize("QdDItkzUEtrPfSmocKl40to2EVnY6zIy","https://api.dkviet.com/","FINVIET")
  },[])
  const startEIDSDK = () => {
    EidSdk.start((result: Eid) => {
      console.log('log from ', typeof result, result);
      if (result) setData(result);
    });
  };
  return (
    <View
      style={{
        flex: 1,

        backgroundColor: 'white',
      }}
    >
      <TouchableOpacity
        onPress={startEIDSDK}
        style={{
          backgroundColor: 'blue',
          paddingHorizontal: 10,
          paddingVertical: 6,
          borderRadius: 5,
          marginTop: 30,
        }}
      >
        <Text style={{ color: 'white', fontSize: 18 }}>
          Start Native eid sdk
        </Text>
      </TouchableOpacity>
      {data != null && (
        <ScrollView>
          <Image
            style={{ height: 200, width: 150, resizeMode: 'cover' }}
            source={{
              uri: 'data:image/png;base64,' + data.personOptionalDetails?.face,
            }}
          />
          {/* <Text style={{color:'black'}}>{data.personOptionalDetails?.fullname}</Text> */}
          <View style={{ flex: 1 }}>
            {data?.personOptionalDetails != null &&
              Object.entries(data?.personOptionalDetails).map(
                ([key, value]) => {
                  if (key != 'face') {
                    return (
                      <View
                        key={key}
                        style={{
                          flexDirection: 'row',
                          flex: 1,
                          margin: 10,
                          justifyContent: 'flex-start',
                          alignItems: 'center',
                        }}
                      >
                        <Text style={{ fontWeight: 'bold', color: 'black' }}>
                          {getTitle(key)}:{' '}
                        </Text>
                        <Text style={{ color: 'black', flex: 1 }}>{value}</Text>
                      </View>
                    );
                  }
                }
              )}
          </View>
        </ScrollView>
      )}
    </View>
  );
}

const getTitle = (key: string) => {
  switch (key) {
    case 'eidNumber':
      return 'Số CCCD'
    case 'fullname':
      return 'Họ và tên';
    case 'gender':
      return 'Giới tính';
    case 'dateOfBirth':
      return 'Ngày sinh';
    case 'age':
      return 'Tuổi';
    case 'dateOfIssue':
      return 'Ngày cấp';
    case 'dateOfExpiry':
      return 'Có giá trị đến';
    case 'ethnicity':
      return 'Dân tộc';
    case 'religion':
      return 'Tôn giáo';
    case 'placeOfOrigin':
      return 'Quê quán';
    case 'placeOfResidence':
      return 'Thường trú';
    case 'personalIdentification':
      return 'Đặc điểm nhận dạng';
    case 'fatherName':
      return 'Tên bố';
    case 'motherName':
      return 'Tên mẹ';
    case 'spouseName':
      return 'Tên vợ/chồng';
    case 'oldEidNumber':
      return 'Số CMND';
    default:
      return '';
  }
};
