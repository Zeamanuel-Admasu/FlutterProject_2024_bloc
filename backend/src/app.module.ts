import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthService } from './application/auth/auth.service'; // Import AuthService

import { TablesModule } from './application/table/tables.module';
import { ReserveModule } from './application/reservation/reserve.module';
import { AuthModule } from './application/auth/auth.module';
import { JwtModule } from '@nestjs/jwt';
import { UserSchema } from './domain/user.model';
import { AdminSchema } from './domain/admin.model';
import { AuthRepository } from './infrastructure/auth/auth.repository';




@Module({
  imports: [
    AuthModule,
    ReserveModule,
    TablesModule,
    MongooseModule.forRoot(
      'mongodb://localhost:27017/TablesDB',
    ),
    JwtModule.register({ secret: 'jwt-secret' }),
    MongooseModule.forFeature([{ name: 'User', schema: UserSchema },{ name: 'Admin', schema: AdminSchema },])
  ],
  controllers: [AppController],
  providers: [AppService,AuthService,AuthRepository
  ],
})
export class AppModule {}
