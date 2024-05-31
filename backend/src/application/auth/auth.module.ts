import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { JwtModule } from '@nestjs/jwt';

import { AuthController } from '../../Presentation/auth/auth.controller';
import { AuthService } from './auth.service';
import { UserSchema } from 'src/domain/user.model';
import { AdminSchema } from 'src/domain/admin.model';
import { AuthRepository } from 'src/infrastructure/auth/auth.repository';

@Module({
  imports: [

    MongooseModule.forFeature([{ name: 'User', schema: UserSchema }, { name: 'Admin', schema: AdminSchema }]),
    JwtModule.register({ secret: 'jwt-secret', signOptions: { expiresIn: '10d' } })
  ],
  controllers: [AuthController],
  providers: [AuthService,AuthRepository],
  exports: [AuthService] 
})
export class AuthModule {}
