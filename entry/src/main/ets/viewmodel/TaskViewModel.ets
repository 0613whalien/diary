

import Logger from '../common/utils/Logger';
import TaskInfoApi from '../common/database/tables/TaskInfoApi';
import { padTo2Digits } from '../common/utils/Utils';
import TaskInfo, { oneWeek } from './TaskInfo';

/**
 * @description Get all task status
 * @return object[] Database query results
 */
export const getAllTask = () => {
  return new Promise<TaskInfo[]>((resolve) => {
    TaskInfoApi.query((res: TaskInfo[]) => {
      if (res?.length === 0) {
        Logger.warn('queryTaskList', 'has no data!!');
        resolve(res ?? []);
      }
      Logger.info('queryTaskList', 'task size }' + res.length);
      resolve(res);
    })
  });
}

/**
 * @param params:TaskInfo
 */
export const addTask = (taskInfo: TaskInfo) => {
  if (!taskInfo) {
    Logger.error('addTask', 'params is null!');
    return new Promise<number>((resolve) => {
      resolve(-1);
    });
  }
  return new Promise<number>(async (resolve, reject) => {
    Logger.info('TaskViewModel', 'addTask');

    TaskInfoApi.insertData(taskInfo, (isDone: number) => {
      resolve(isDone)
      if (isDone) {
        Logger.info('AppStart', 'Insert taskInfo success: ' + JSON.stringify(taskInfo));
      }
    });
  });
}

/**
 * @param params:TaskInfo
 */
export const updateTask = (taskInfo: TaskInfo) => {
  if (!taskInfo) {
    Logger.error('updateTask', 'params is null!');
    return new Promise<number>((resolve) => {
      resolve(-1);
    });
  }
  return new Promise<number>(async (resolve, reject) => {
    Logger.info('TaskViewModel', 'updateTask');

    TaskInfoApi.updateDataById(taskInfo, (isDone: number) => {
      resolve(isDone)
      if (isDone) {
        Logger.info('AppStart', 'update taskInfo success: ' + JSON.stringify(taskInfo));
      }
    });
  });
}

/**
 * @param params:TaskInfo
 */
export const deleteTask = (taskInfo: TaskInfo) => {
  if (!taskInfo) {
    Logger.error('deleteTask', 'params is null!');
    return new Promise<number>((resolve) => {
      resolve(-1);
    });
  }
  return new Promise<number>(async (resolve, reject) => {
    Logger.info('TaskViewModel', 'deleteTask');

    TaskInfoApi.deleteDataByID(taskInfo, (isDone: number) => {
      resolve(isDone)
      if (isDone) {
        Logger.info('AppStart', 'delete taskInfo success: ' + JSON.stringify(taskInfo));
      }
    });
  });
}

/**
 * @description Returns the timestamp of today's selected time
 * @param currentTime
 * @return timestamp
 */
export function returnTimeStamp(currentTime: string) {
  const timeString = `${new Date().toDateString()} ${currentTime}`;
  return new Date(timeString).getTime();
}

/**
 * @description It is used for formatting time and displayed in the form of HH: mm
 * @param value
 */
export const formatTime = (value: TimePickerResult) => {
  let hour = value?.hour ? value?.hour : 8;
  let minute = value?.minute ? value?.minute : 0;
  return `${padTo2Digits(hour)}:${padTo2Digits(minute)}`;
}


