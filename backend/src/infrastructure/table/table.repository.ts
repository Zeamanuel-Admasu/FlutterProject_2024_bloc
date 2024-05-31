import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Table } from '../../domain/table.model';

@Injectable()
export class TableRepository {
  constructor(
    @InjectModel('Table') private readonly tableModel: Model<Table>,
  ) {}

  async findByTableNumber(tableNumber: number): Promise<Table | null> {
    return await this.tableModel.findOne({ tableNumber }).exec();
  }

  async findAll(): Promise<Table[]> {
    return await this.tableModel.find().exec();
  }

  async findById(id: string): Promise<Table | null> {
    return await this.tableModel.findById(id).exec();
  }

  async create(tableData: Partial<Table>): Promise<Table> {
    const newTable = new this.tableModel(tableData);
    return await newTable.save();
  }

  async update(tableId: string, updateData: Partial<Table>): Promise<void> {
    await this.tableModel.findByIdAndUpdate(tableId, updateData).exec();
  }

  async deleteById(tableNum: number): Promise<void> {
    const result = await this.tableModel.deleteOne({ tableNumber: tableNum }).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find table.');
    }
  }
  async findSatisfyingTables(tableType: string, tableSeats: number): Promise<Table[]> {
    console.log(tableType,tableSeats);
    return await this.tableModel.find({ Type: tableType, Number_of_seats: { $gte: tableSeats } }).exec();
  }
  
}
