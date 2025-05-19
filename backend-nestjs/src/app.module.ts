import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [UsersModule, AuthModule, TodosModule, TestmoduleModule],
  controllers: [AppController, UsersController, AuthController, TodosController],
  providers: [AppService, UsersService, AuthService, TodosService],
})
export class AppModule {}
  