import AccountTypeModel from '../accountType/AccountTypeModel';

export enum AccountExpensesType {
  MEALS,    // 餐食
  MEDICAL,  // 医疗
  TRANSPORT, // 交通
  HOUSE,    // 住房



  SOCIAL,    // 社交

  SHOPPING,  // 购物
  ENTERTAINMENT,  // 娱乐

  OTHER,    // 其他
}

export enum AccountIncomeType {
  STUDY1,
  STUDY2,
  STUDY3,
  STUDY,
  OTHER,     //  其他
}

export enum AccountType {
  EXPENSES,
  INCOME,
}

export interface AccountInfo {
  type: AccountExpensesType | AccountIncomeType;
  accountType: AccountType;
  amount: number;
  time: number;
  description?: string;
}

// 数据库映射字段
export enum ColumnType {
  LONG,
  DOUBLE,
  STRING,
  BLOB,
}
export interface ColumnInfo {
  name: string;
  columnName: string;
  type: ColumnType;
}

export interface ItemRecordInfo {
  id: number;
  type: number;
  accountType: number;
  description?: string;
  createTime: number;
  amount: number;
  time: number;
  info: AccountTypeModel;
}

export interface GroupByDate {
  time: number;
  expenses: number;
  income: number;
  records: ItemRecordInfo[]
}

export interface StatsByDate {
  time: number;
  expenses: number;
  income: number;
}

export interface StatsByType {
  amount: number;
  count: number;
  info: AccountTypeModel;
}