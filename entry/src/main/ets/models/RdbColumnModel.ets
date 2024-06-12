
import ColumnInfo from '../viewmodel/ColumnInfo';



//待办事项的数据库字段
export const columnTaskInfoInfoList: Array<ColumnInfo> = [
  new ColumnInfo('id', 'integer', -1, false, true, true),
  new ColumnInfo('taskID', 'integer', -1, false, false, false),
  new ColumnInfo('createTime', 'long', -1, false, false, false),
  new ColumnInfo('title', 'text', -1, false, false, false),
  new ColumnInfo('content', 'text', -1, false, false, false),
  new ColumnInfo('isDone', 'boolean', -1, true, false, false),
];


