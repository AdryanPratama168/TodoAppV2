import { Controller, Get, Post, Body, Patch, Param, Delete, HttpException, HttpStatus } from '@nestjs/common';
import { TasksService } from './tasks.service';
import { CreateTaskDto, UpdateTaskDto } from './dto/task.dto';

@Controller('tasks')
export class TasksController {
  constructor(private readonly tasksService: TasksService) {}

  @Post()
  async create(@Body() createTaskDto: CreateTaskDto) {
    try {
      const task = await this.tasksService.create(createTaskDto);
      return {
        success: true,
        message: 'Task created successfully',
        data: task
      };
    } catch (error) {
      throw new HttpException({
        success: false,
        message: error.message || 'Failed to create task',
      }, HttpStatus.BAD_REQUEST);
    }
  }

  @Get()
  async findAll() {
    try {
      const tasks = await this.tasksService.findAll();
      return {
        success: true,
        data: tasks
      };
    } catch (error) {
      throw new HttpException({
        success: false,
        message: error.message || 'Failed to fetch tasks',
      }, HttpStatus.INTERNAL_SERVER_ERROR);
    }
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    try {
      const task = await this.tasksService.findOne(+id);
      return {
        success: true,
        data: task
      };
    } catch (error) {
      throw new HttpException({
        success: false,
        message: error.message || 'Failed to fetch task',
      }, HttpStatus.NOT_FOUND);
    }
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateTaskDto: UpdateTaskDto) {
    try {
      const task = await this.tasksService.update(+id, updateTaskDto);
      return {
        success: true,
        message: 'Task updated successfully',
        data: task
      };
    } catch (error) {
      throw new HttpException({
        success: false,
        message: error.message || 'Failed to update task',
      }, HttpStatus.BAD_REQUEST);
    }
  }

  @Delete(':id')
  async remove(@Param('id') id: string) {
    try {
      await this.tasksService.remove(+id);
      return {
        success: true,
        message: 'Task deleted successfully'
      };
    } catch (error) {
      throw new HttpException({
        success: false,
        message: error.message || 'Failed to delete task',
      }, HttpStatus.NOT_FOUND);
    }
  }
}