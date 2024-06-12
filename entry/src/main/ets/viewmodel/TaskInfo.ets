
import { oneWeekDictFunc } from '../common/utils/Utils';


export default class TaskInfo {
    id: number;
    taskID: number;
    createTime: number;
    isDone: boolean;
    title: string;
    content: string

    constructor(id: number, taskId: number, isDone: boolean, createTime: number, title: string, content: string) {
        this.id = id;
        this.taskID = taskId;
        this.isDone = isDone;
        this.createTime = createTime;
        this.title = title;
        this.content = content;
    }
}

export const oneWeek = oneWeekDictFunc();
