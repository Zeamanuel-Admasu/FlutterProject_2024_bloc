import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ReserveController } from '../../Presentation/reservation/reserve.controller';
import { ReserveService } from './reserve.service';
import { ReserveSchema } from '../../domain/reserve.model';
import { TableSchema } from '../../domain/table.model';
import { ReserveRepository } from 'src/infrastructure/reservation/reservation.repository';
import { TableRepository } from 'src/infrastructure/table/table.repository';
import { TablesModule } from '../table/tables.module';


@Module({
  imports: [
    TablesModule,
    MongooseModule.forFeature([{ name: 'Reserve', schema: ReserveSchema },{ name: 'Table', schema: TableSchema }]),
  ],
  controllers: [ReserveController],
  providers: [ReserveService,ReserveRepository,TableRepository],
})
export class ReserveModule {}
