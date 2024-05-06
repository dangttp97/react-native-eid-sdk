export type Eid = {
  personOptionalDetails: PersonOptionalDetails | null;
};

type PersonOptionalDetails = {
  age: string | null;
  dateOfBirth: string | null;
  dateOfExpiry: string | null;
  dateOfIssue: string | null;
  eidNumber: string | null;
  ethnicity: string | null;
  face: string | null;
  fatherName: string | null;
  fullname: string | null;
  gender: string | null;
  motherName: string | null;
  oldEidNumber: string | null;
  personalIdentification: string | null;
  placeOfOrigin: string | null;
  placeOfResidence: string | null;
  religion: string | null;
  spouseName: string | null;
};
