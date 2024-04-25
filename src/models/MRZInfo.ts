import type { DocumentType } from './DocumentType';

export type MRZInfo = {
  documentType: keyof typeof DocumentType;
  documentCode: string;
  issuingState: string;
  nationality: string;
  documentNumber: string;
  dateOfBirth: string;
  gender: string;
  dateOfExpiry: string;
};
