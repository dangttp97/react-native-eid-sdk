# Finviet Technology

# react-native-eid-sdk

Thư viện React Native cho EID của DK Technology

## 1. Cài đặt

```sh
npm install react-native-eid-sdk
```

hoặc

```sh
yarn add react-native-eid-sdk
```

## 2. Import

```js
import EidSdk from 'react-native-eid-sdk';

// ...

EidSdk.initialize('apiKey', 'apiBaseUrl', 'customerCode');
```

Trong đó hàm initialize được declare ở [đây](#khởi-tạo)

## 3. Methods

### Khởi tạo

```js
/**
 *
 * @param {string} apiKey - Key được cung cấp bởi DK Technology
 * @param {string} apiBaseUrl - Base URL được cung cấp bởi DK Technology để lib truy cập vào CSDL quốc gia.
 * @param {string} customerCode - Dùng để DK Technology so sánh hoặc đo đạc gì đó thông qua apiBaseUrl được define bên trên
 */

const initialize = (apiKey: string, apiBaseUrl: string, customerCode: string) => void
```

<br/>

### Lấy thông tin CCCD bằng NFC

- <b>Step 1</b>: Đọc mã MRZ (Machine Readable Zone)
- <b>Step 2</b>: Áp CCCD vào mặt sau điện thoại để đọc chip NFC
- <b>Step 3</b>: Trả về Promise<[PersonalInfo](#personalinfo)>

```js
/**
 * Lấy thông tin CCCD bằng NFC
 *
 * @param {string} imageUrlStr String của hình ảnh có chứa MRZ CCCD (Note: sẽ làm thêm view live để lấy auto sau, không cần phải chụp)
 *
 * @returns {Promise<PersonalInfo>} Thông tin của công dân
 */

const getPersonalInfo = (imageUrlStr: string) => Promise<PersonalInfo>

```

<br/>

### Verify khuôn mặt (eKYC)

- Step 1: Đọc MRZ
- Step 2: Áp CCCD vào mặt sau điện thoại để đọc chip NFC
- Step 3: Mở live view để scan khuôn mặt
- Step 4: Trả về Promise<[EkycResult](#ekycresult)>

```js
/**
 * @returns {Promise<EkycResult>} - Thông tin verify khuôn mặt có phải chính chủ hay không
 */
const showScanFaceView = () => Promise<EkycResult>
```

## Models

### EkycResult

| <b>Name</b> | <b>Kiểu dữ liệu</b> |
| :---------: | :-----------------: |
|   isMatch   |       boolean       |

### PersonalInfo

| <b>Name</b>            | <b>Kiểu dữ liệu</b> | <b>Chú giải</b>        |
| ---------------------- | ------------------- | ---------------------- |
| eidNumber              | string / undefined  | Số CCCD                |
| fullName               | string / undefined  | Họ và tên              |
| gender                 | string / undefined  | Giới tính              |
| dateOfIssues           | string / undefined  | Ngày cấp               |
| dateOfExpiry           | string / undefined  | Ngày hết hạn           |
| nationality            | string / undefined  | Quốc tịch              |
| ethnicity              | string / undefined  | Dân tộc                |
| religion               | string / undefined  | Tôn giáo               |
| placeOfOrigin          | string / undefined  | Quê quán               |
| placeOfResidence       | string / undefined  | Nơi thường trú         |
| personalIdentification | string / undefined  | Đặc điểm nhận dạng     |
| fatherName             | string / undefined  | Họ tên cha             |
| motherName             | string / undefined  | Họ tên mẹ              |
| sprouseName            | string / undefined  | Họ tên người phối ngẫu |
| oldEidNumber           | string / undefined  | Số CMND cũ             |
