import {
  Controller,
  Post,
  Body,
  Get,
  Param,
  Patch,
  Delete,
  Res,
  UseGuards
} from '@nestjs/common';
import { Request, Response } from 'express';

import { TableService } from '../../application/table/tables.service';
import { AdminAuthGuard } from 'src/auth/AdminAuthGuard';

@Controller('tables')
export class TablesController {
  constructor(private readonly tableService: TableService) {}
  

  @Post()
  @UseGuards(AdminAuthGuard)
  async addTable(
    @Body('seats') tabSeats: number,
    @Body('type') tabType: string,
    @Body('floor') tabFloor: number,
    @Body('tableNUM') tabNum: number,

) {
  console.log("jeeeeeeeeeeeeeee")
    const resp = await this.tableService.insertTable(
      tabNum,
      tabSeats,
      tabType,
      tabFloor
    );
    console.log(resp);
    return resp;
  }

  @Get()
  @UseGuards(AdminAuthGuard)
  async getAllTables(@Res() res:Response) {
    const tables = await this.tableService.getTables();
    return res.json(tables);
  }

  @Get(':tableNum')
  @UseGuards(AdminAuthGuard)
  async getTable(@Param('tableNum') tabNum: number) {
    const result = await this.tableService.getSingleTable(tabNum);
    return result;
  }

  @Patch(':tableNum')
  @UseGuards(AdminAuthGuard)
  async updateTable(
    @Param('tableNum') tabNumm: number,
    @Body('updseats') tabSeats: number,
    @Body('updtype') tabType: string,
    @Body('updfloor') tabFloor: number,
  ) {
    console.log("yeeesayagfhesg")
    const resp = await this.tableService.updateTable(tabNumm, tabSeats, tabType, tabFloor);
    return resp
    
  }

  @Delete(':tableNum')
  @UseGuards(AdminAuthGuard)
  async removeTable(@Param('tableNum') tabNum: number) {
    console.log("dalfkldasdf;laskfdldkasd");
      return await this.tableService.deleteTable(tabNum);
  }
}
