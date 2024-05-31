import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { TablesController } from '../../Presentation/table/tables.controller';
import { TableService } from './tables.service';
import { TableSchema } from '../../domain/table.model';
import { JwtModule } from '@nestjs/jwt';
import { TableRepository } from 'src/infrastructure/table/table.repository';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Table', schema: TableSchema }]),
    JwtModule.register({ secret: 'jwt-secret' })
  ],
  controllers: [TablesController],
  providers: [TableService,TableRepository],
})
export class TablesModule {}
