import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { JwtModule } from '@nestjs/jwt';

import { ReserveController } from '../../Presentation/reservation/reserve.controller';
import { ReserveService } from './reserve.service';
import { ReserveSchema } from '../../domain/reserve.model';
import { TableSchema } from '../../domain/table.model';
import { ReserveRepository } from 'src/infrastructure/reservation/reservation.repository';
import { TableRepository } from 'src/infrastructure/table/table.repository';
import { TablesModule } from '../table/tables.module';
import { AuthService } from 'src/application/auth/auth.service'; // Import AuthService here
import { AuthModule } from '../auth/auth.module';
import { AuthRepository } from 'src/infrastructure/auth/auth.repository';
import { UserSchema } from 'src/domain/user.model';
import { AdminSchema } from 'src/domain/admin.model';
import { JwtAuthGuard } from 'src/auth/JwtAuthGuard';

@Module({
  imports: [
    AuthModule,
    TablesModule,
    MongooseModule.forFeature([{ name: 'Reserve', schema: ReserveSchema },{ name: 'Table', schema: TableSchema },{ name: 'Reserve', schema: ReserveSchema },
    { name: 'Table', schema: TableSchema },
    // Add UserModel and AdminModel to the feature modules
    { name: 'User', schema: UserSchema },
    { name: 'Admin', schema: AdminSchema },]),
    JwtModule.register({ secret: 'jwt-secret' }), // Import JwtModule and register it
  ],
  controllers: [ReserveController],
  providers: [ReserveService,ReserveRepository,TableRepository, AuthService, AuthRepository,JwtAuthGuard], // Add AuthService to providers array
})
export class ReserveModule {}
