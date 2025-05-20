// src/tasks/dto/create-task.dto.ts
import { IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateTaskDto {
  @IsString()
  @IsNotEmpty()
  readonly title: string;

  @IsString()
  @IsOptional()
  readonly description?: string;

  @IsString()
  @IsOptional()
  readonly date?: string; // format 'yyyy-MM-dd'

  @IsString()
  @IsOptional()
  readonly category?: string;
}

export class UpdateTaskDto {
  @IsString()
  @IsOptional()
  readonly title?: string;

  @IsString()
  @IsOptional()
  readonly description?: string;

  @IsString()
  @IsOptional()
  readonly date?: string;

  @IsString()
  @IsOptional()
  readonly category?: string;
}
