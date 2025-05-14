import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Aktifkan CORS agar dapat diakses dari berbagai origin, termasuk flutter web/emulator
  app.enableCors();

  await app.listen(3000);
}
bootstrap();
