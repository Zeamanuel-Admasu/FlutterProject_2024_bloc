import { Injectable, NotFoundException } from '@nestjs/common';
import { TableRepository } from '../../infrastructure/table/table.repository';
import { Table } from '../../domain/table.model';

@Injectable()
export class TableService {
  constructor(private readonly tableRepository: TableRepository) {}

  async insertTable(
    tableNum: number,
    seats: number,
    type: string,
    floor: number,
  ): Promise<{ status: string; message: string }> {
    const existingTable = await this.tableRepository.findByTableNumber(tableNum);
    if (existingTable) {
      return { status: 'error', message: 'Table number already exists.' };
    }

    await this.tableRepository.create({
      tableNumber: tableNum,
      Number_of_seats: seats,
      Type: type,
      floor,
    });

    return { status: 'success', message: 'Table successfully added.' };
  }

  async getTables(): Promise<Table[]> {
    return await this.tableRepository.findAll();
  }

  async getSingleTable(tabNum: number): Promise<Object> {
    const table = await this.tableRepository.findByTableNumber(tabNum);
    console.log(table);
    if (!table) {
      return { error: 'Table does not exist.' };
    }
    return {
      "status": "success",

        tableNumber: table.tableNumber,
        floor: table.floor,
        type: table.Type,
         seats : table.Number_of_seats
      
    };
  }

  async updateTable(
    tableNum: number,
    seats: number,
    type: string,
    floor: number,
  ): Promise<{ status: string; message: string }> {
    const existingTable = await this.tableRepository.findByTableNumber(tableNum);
    if (!existingTable) {
      return { status: 'error', message: 'Table not found.' };
    }

    await this.tableRepository.update(existingTable._id, {
      Number_of_seats: seats,
      Type: type,
      floor: floor,
    });

    return { status: 'success', message: 'Table successfully updated.' };
  }

  async deleteTable(tabNum: number): Promise<{ status: string; message: string }> {
    await this.tableRepository.deleteById(tabNum);
    return { status: 'success', message: 'Table successfully deleted.' };
  }
}
